# frozen_string_literal: true

Rollbar.configure do |config|
  config.access_token = ENV.fetch('ROLLBAR_ACCESS_TOKEN', nil)
  config.enabled = Rails.env.production?
  config.environment = ENV.fetch('ROLLBAR_ENV', nil) || Rails.env
end
