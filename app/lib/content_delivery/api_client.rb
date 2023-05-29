# frozen_string_literal: true

require 'digest'
require 'faraday'
require 'faraday/retry'

module ContentDelivery
  class ApiClient
    URL = "https://cdn.contentful.com/spaces/#{ENV.fetch('SPACE_ID', nil)}".freeze

    def self.default
      @default ||= ApiClient.new
    end

    def initialize
      validate_configuration!

      @client = Faraday.new(*config) do |f|
        f.request :json
        f.response :json
        f.request :retry, retry_options
        f.response :raise_error
        f.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug do |formatter|
          formatter.filter(/^(Authorization:).+$/i, '\1[REDACTED]')
        end
        f.adapter :net_http
      end
    end

    def call(verb, api_path)
      response = @client.public_send(verb, "#{URL}#{api_path}")
      return response.body unless response.body.is_a?(String)

      JSON.parse(response.body)
    end

    private

    def retry_options
      {
        max: 5,
        interval: 0.5,
        backoff_factor: 2,
        interval_randomness: 0.5,
        retry_statuses: [429],
        methods: [:get]
      }
    end

    def config
      [
        {
          headers: { authorization: "Bearer #{ENV.fetch('AUTH_TOKEN', nil)}" },
          request: {
            open_timeout: 1,
            read_timeout: 5,
            write_timeout: 5
          }
        }
      ]
    end

    def validate_configuration!
      raise ArgumentError, 'Add SPACE_ID in .env' if ENV['SPACE_ID'].blank?
      raise ArgumentError, 'Add AUTH_TOKEN in .env' if ENV['AUTH_TOKEN'].blank?
    end
  end
end
