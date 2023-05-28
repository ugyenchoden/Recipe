# frozen_string_literal: true

module Gateways
  module ContentDeliveryGateway
    def self.client
      @_client ||= ContentDelivery::ApiClient.default
    end
  end
end
