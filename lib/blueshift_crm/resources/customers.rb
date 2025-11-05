# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class Customers < Base
      # GET /api/v1/customers/{uuid}
      def get(uuid:)
        client.get("/api/v1/customers/#{uuid}")
      end

      # GET /api/v1/customers?email=... or customer_id=...
      def search(email: nil, customer_id: nil)
        client.get("/api/v1/customers", params: { email:, customer_id: })
      end

      # POST /api/v1/customers (create or update)
      def upsert(payload:)
        client.post("/api/v1/customers", body: payload)
      end

      # GET /api/v1/customer_search/show_events?uuid=...
      def events(uuid:, limit: nil)
        client.get("/api/v1/customer_search/show_events", params: { uuid:, limit: })
      end
    end
  end
end
