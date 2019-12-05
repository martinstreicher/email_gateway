# frozen_string_literal: true

HttpLog.configure do |config|
  config.compact_log = true
  config.enabled = ENV.fetch('HTTPLOG', false).to_boolean
  config.filter_parameters = %w[password] # Mask the values of sensitive request parameters
  config.logger = Rails.logger
end
