# frozen_string_literal: true

module Gateways
  def self.content_delivery
    @content_delivery ||= ContentDelivery::ApiClient.default
  end
end
