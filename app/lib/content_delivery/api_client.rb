# frozen_string_literal: true

require 'digest'
require 'faraday'
require 'faraday/retry'
require 'faraday/follow_redirects'

module ContentDelivery
  class ApiClient
    URL = "https://cdn.contentful.com/spaces/#{ENV.fetch('SPACE_ID', nil)}".freeze
    MAX_RETRIES = 3

    def self.default
      @default ||= ApiClient.new
    end

    def initialize # rubocop:disable Metrics/MethodLength
      validate_configuration!

      @client = Faraday.new(*config) do |f|
        f.request :json
        f.response :json
        f.request :retry, retry_options
        f.response :follow_redirects
        f.response :raise_error
        f.response :logger, logger, headers: true, bodies: true, log_level: :debug do |formatter|
          formatter.filter(/^(Authorization:).+$/i, '\1[REDACTED]')
        end
        f.adapter :net_http
      end
    end

    def call(verb, api_path) # rubocop:disable Metrics/MethodLength
      response = @client.public_send(verb, "#{URL}#{api_path}")
      format_response(response.body)
    rescue Faraday::BadRequestError, Faraday::UnauthorizedError, Faraday::ForbiddenError, Faraday::ResourceNotFound,
           Faraday::UnprocessableEntityError => e
      handle_error(e)
    rescue Faraday::ClientError => e
      log_error('Content Delivery API error', e)
      {}
    rescue StandardError => e
      log_error('Unknown Error! Please check the details', e)
      {}
    end

    private

    def handle_error(error)
      body = JSON.parse(error.response[:body])
      log_error(body['message'])
      send_mail(error, body)
      # return empty body
      {}
    end

    def send_mail(error, body)
      status = error.response[:status]
      ContentDeliveryMailer.notify_sync_failure(status, body['message']).deliver
    end

    def logger
      ActiveSupport::Logger.new('log/content_delivery_api.log', 'daily', binmode: true)
    end

    def format_response(response_body)
      return response_body unless response_body.is_a?(String)

      JSON.parse(response_body)
    end

    def retry_options # rubocop:disable Metrics/MethodLength
      {
        max: 5,
        interval: 0.5,
        backoff_factor: 2,
        interval_randomness: 0.5,
        retry_statuses: [429, 500, 502, 503, 504],
        methods: [:get],
        retry_block: lambda do |env, *|
          message = "Error while calling Content Deliver API Endpoint: #{env.url}"
          params = { url: env.url, response: env.body, status: env.status }
          log_error(message, params)
        end
      }
    end

    def log_error(message, params = {})
      Rollbar.error(message, params)
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
