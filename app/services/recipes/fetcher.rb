# frozen_string_literal: true

module Recipes
  class Fetcher < ApplicationService
    def run
      responses = []
      fetch_data(0, 'recipe') do |response|
        responses << process_recipes(response)
      end
      responses.flatten
    end

    private

    def process_recipes(response)
      recipes = []
      assets = response.dig('includes', 'Asset').map { |asset| Asset.new(asset) }
      response['items'].each do |item|
        recipe_object = Recipe.new(item)
        asset_object = assets.find { |asset| asset.id == recipe_object.photo_id }
        recipes << {
          id: recipe_object.id,
          title: recipe_object.title,
          file_url: asset_object.file_url
        }
      end
      recipes
    end
  end
end
