# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class Events < Base
      # POST /api/v1/event (requires Event API key)
      def send_event(event:)
        client.request(:post, "/api/v1/event", body: event, user_api: false)
      end

      # GET /api/v1/event/debug
      def latest_debug
        client.get("/api/v1/event/debug")
      end

      # GET /api/v1/event/history
      def history(event: nil, limit: nil)
        client.get("/api/v1/event/history", params: { event:, limit: })
      end
    end
  end
end
