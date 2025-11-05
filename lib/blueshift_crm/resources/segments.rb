# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class Segments < Base
      # GET /api/v1/segments/list
      def list
        client.get("/api/v1/segments/list")
      end

      # GET /api/v1/segments/{segment_uuid}/matching_users.json
      def matching_users_count(segment_uuid:)
        client.get("/api/v1/segments/#{segment_uuid}/matching_users.json")
      end
    end
  end
end
