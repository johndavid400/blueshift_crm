# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class Campaigns < Base
      # GET /api/v2/campaigns.json
      def list(page: nil, per_page: nil, updated_after: nil)
        client.get("/api/v2/campaigns.json", params: { page:, per_page:, updated_after: })
      end

      # GET /api/v1/campaigns.json
      def performance(start_date:, end_date:, timezone: nil)
        client.get("/api/v1/campaigns.json", params: { start_date:, end_date:, timezone: })
      end

      # GET /api/v1/campaigns/{uuid}/detail.json
      def detail(uuid:)
        client.get("/api/v1/campaigns/#{uuid}/detail.json")
      end

      # Optional: POST /api/v1/campaigns/{type}
      def create(campaign_type:, payload:)
        client.post("/api/v1/campaigns/#{campaign_type}", body: payload)
      end
    end
  end
end
