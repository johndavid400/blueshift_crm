# frozen_string_literal: true

require "json"
require "faraday"

require_relative "blueshift_crm/version"
require_relative "blueshift_crm/error"
require_relative "blueshift_crm/client"

# resources
require_relative "blueshift_crm/resources/base"
require_relative "blueshift_crm/resources/campaigns"
require_relative "blueshift_crm/resources/events"
require_relative "blueshift_crm/resources/customers"
require_relative "blueshift_crm/resources/segments"
require_relative "blueshift_crm/resources/adapters"
require_relative "blueshift_crm/resources/custom_user_lists"

module BlueshiftCRM
  # Entry module namespace
end

