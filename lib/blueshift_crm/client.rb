# frozen_string_literal: true

module BlueshiftCRM
  class Client
    DEFAULT_TIMEOUT = 30
    READONLY_GETS   = %w[GET].freeze

    attr_reader :base_url, :site_id

    # region: "eu" or nil
    # user_api_key: required for most endpoints (you called this blueshift_api_password; both envs supported)
    # event_api_key: required for POST /api/v1/event
    def initialize(
      region: ENV["BLUESHIFT_REGION"],
      user_api_key: ENV["BLUESHIFT_USER_API_KEY"] || ENV["blueshift_api_password"],
      event_api_key: ENV["BLUESHIFT_EVENT_API_KEY"] || ENV["event_api_key"],
      site_id: ENV["BLUESHIFT_SITE_ID"] || ENV["site_id"],
      timeout: DEFAULT_TIMEOUT
    )
      @base_url = region.to_s.downcase == "eu" ? "https://api.eu.getblueshift.com" : "https://api.getblueshift.com"
      @user_api_key  = user_api_key
      @event_api_key = event_api_key
      @site_id       = site_id
      @timeout       = timeout

      raise ArgumentError, "Missing user_api_key (BLUESHIFT_USER_API_KEY or blueshift_api_password)" unless @user_api_key
      raise ArgumentError, "Missing event_api_key (BLUESHIFT_EVENT_API_KEY or event_api_key)" unless @event_api_key
      raise ArgumentError, "Missing site_id (BLUESHIFT_SITE_ID or site_id)" unless @site_id

      @conn_user  = build_conn(auth_key: @user_api_key)
      @conn_event = build_conn(auth_key: @event_api_key)
    end

    # ---- Public resource accessors ----
    def campaigns         = @campaigns         ||= Resources::Campaigns.new(self)
    def events            = @events            ||= Resources::Events.new(self)
    def customers         = @customers         ||= Resources::Customers.new(self)
    def segments          = @segments          ||= Resources::Segments.new(self)
    def adapters          = @adapters          ||= Resources::Adapters.new(self)
    def custom_user_lists = @custom_user_lists ||= Resources::CustomUserLists.new(self)

    # ---- Core HTTP helpers ----
    def get(path, params: {}, user_api: true)
      request(:get, path, params: with_site_id(params), user_api: user_api)
    end

    def post(path, body: {}, params: {}, user_api: true)
      request(:post, path, body: body, params: with_site_id(params), user_api: user_api)
    end

    def put(path, body: {}, params: {}, user_api: true)
      request(:put, path, body: body, params: with_site_id(params), user_api: user_api)
    end

    def request(method, path, body: nil, params: {}, user_api: true)
      conn = user_api ? @conn_user : @conn_event
      resp = conn.public_send(method, path) do |req|
        req.params.update(params.compact)
        req.headers["Content-Type"] = "application/json" unless READONLY_GETS.include?(method.to_s.upcase)
        req.body = JSON.dump(body) if body && !READONLY_GETS.include?(method.to_s.upcase)
      end

      parse_response(resp)
    rescue Faraday::ClientError => e
      status = e.response&.dig(:status)
      body   = e.response&.dig(:body)
      raise Error.new("HTTP #{status || 'error'}: #{e.message}", status: status, body: body)
    rescue Faraday::Error => e
      raise Error.new("HTTP error: #{e.message}")
    end

    private

    def with_site_id(params)
      { site_id: @site_id }.merge(params || {})
    end

    def build_conn(auth_key:)
      Faraday.new(url: @base_url) do |f|
        f.request :retry, max: 2, interval: 0.25, backoff_factor: 2, methods: %i[get put post delete]
        f.options.timeout = @timeout
        # HTTP Basic with API key as username and blank password
        f.request :authorization, :basic, auth_key, ""
        f.adapter Faraday.default_adapter
      end
    end

    def parse_response(resp)
      return nil if resp.body.to_s.strip.empty?
      JSON.parse(resp.body)
    rescue JSON::ParserError
      resp.body
    end
  end
end

