# frozen_string_literal: true

module Recipes
  class Fetcher < ApplicationService
    include BatchLoader
    include AttributesHelper
    include Helper

    def run
      fetch_data(0, 'recipe') do |response|
        process_recipes(response)
      end
    end

    private

    def process_recipes(response)
      assets = response.dig('includes', 'Asset').map { |asset| Photo.new(asset) }
      entries = response.dig('includes', 'Entry').map { |entry| Entry.new(entry) }
      create_or_update_entries(entries)
      recipes = response['items'].map { |item| Entry.new(item) }
      create_or_update_recipes(recipes, assets)
    end
  end
end
