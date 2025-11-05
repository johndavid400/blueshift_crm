# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class CustomUserLists < Base
      # GET /api/v1/custom_user_lists/seed_lists
      def seed_lists
        client.get("/api/v1/custom_user_lists/seed_lists")
      end

      # GET /api/v1/custom_user_lists/id/{custom_user_list_id}
      def details(list_id:)
        client.get("/api/v1/custom_user_lists/id/#{list_id}")
      end

      # Optional helpers if you plan to create/manage lists:
      def create(name:, description: nil)
        client.post("/api/v1/custom_user_lists/create", body: { name:, description: })
      end

      def add_user(list_id:, identifier:)
        client.put("/api/v1/custom_user_lists/add_user_to_list/#{list_id}", body: identifier)
      end
    end
  end
end
