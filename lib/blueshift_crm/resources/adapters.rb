# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class Adapters < Base
      # GET /api/v1/account_adapters?channel_name=...&adapter_name=...
      def list(channel_name: nil, adapter_name: nil)
        client.get("/api/v1/account_adapters", params: { channel_name:, adapter_name: })
      end
    end
  end
end
