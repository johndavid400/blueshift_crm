# frozen_string_literal: true

module BlueshiftCRM
  module Resources
    class Base
      def initialize(client)
        @client = client
      end

      private

      attr_reader :client
    end
  end
end

