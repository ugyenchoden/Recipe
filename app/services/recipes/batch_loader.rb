# frozen_string_literal: true

module Recipes
  module BatchLoader
    BATCH_SIZE = 100

    def fetch_data(offset)
      response = make_request(offset)
      return if response.empty? || !response.key?('items')

      yield(response)

      return response if response['total'] < BATCH_SIZE

      fetch_data(offset + BATCH_SIZE)
    end

    def make_request(offset)
      Gateways.content_delivery.call('get', "/entries?content_type=recipe&skip=#{offset}")
    end
  end
end
