# frozen_string_literal: true

module Recipes
  class Fetcher < ApplicationService
    include BatchLoader

    def run
      responses = []
      fetch_data(0, 'recipe') do |response|
        responses << process_recipes(response)
      end
      responses.flatten
    end

    private

    def process_recipes(response)
      assets = response.dig('includes', 'Asset').map { |asset| Asset.new(asset) }
      response['items'].map do |item|
        recipe = Recipe.new(item)
        photo = assets.find { |asset| asset.id == recipe.photo_id }
        {
          id: recipe.id,
          title: recipe.title,
          file_url: photo.file_url
        }
      end
    end
  end
end
