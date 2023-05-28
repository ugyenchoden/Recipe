# frozen_string_literal: true

module Recipes
  module BatchLoader
    BATCH_SIZE = 100

    def fetch_data(offset, content_type)
      response = make_request(offset, content_type)
      response = response.get if response.ok?

      return if response.empty? || !response.key?('items')

      yield(response)

      return if response['total'] < BATCH_SIZE

      fetch_data(offset + BATCH_SIZE, content_type)
    end

    def make_request(offset, content_type)
      Gateways.content_delivery.call('get', "/entries?content_type=#{content_type}&skip=#{offset}")
    end
  end
end
