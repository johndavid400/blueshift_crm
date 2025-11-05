# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "blueshift_crm"
  spec.version       = File.read("lib/blueshift_crm/version.rb").match(/VERSION = "(.+)"/)[1]
  spec.authors       = ["JD Warren"]
  spec.email         = ["johndavid400@gmail.com"]

  spec.summary       = "Ruby client for Blueshift CRM API"
  spec.description   = "A lightweight, Faraday-based Ruby client for Blueshift CRM covering campaigns, events, customers, segments, adapters, and custom user lists."
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/johndavid400/blueshift_crm"

  spec.required_ruby_version = ">= 3.0"

  spec.files         = Dir["lib/**/*", "README.md", "LICENSE*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 2.9", "< 3.0"

  spec.metadata = {
    "rubygems_mfa_required" => "true",
    "source_code_uri" => spec.homepage,
    "changelog_uri"   => "#{spec.homepage}/releases"
  }
end
