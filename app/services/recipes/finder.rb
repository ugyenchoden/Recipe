# frozen_string_literal: true

module Recipes
  class Finder < ApplicationService
    def initialize(id:)
      @id = id
    end

    def run
      response = client.call('get', "/entries/#{@id}")
      r = response.get if response.ok?
      recipe = Recipe.new(r)
      {
        title: recipe.title,
        description: recipe.description,
        file_url: photo(recipe.photo_id).file_url,
        chef: chef(recipe&.chef_id),
        tags: tags(recipe&.tag_ids)
      }
    end

    def chef(id)
      return if id.nil?

      response = client.call('get', "/entries/#{id}")
      c = response.get if response.ok?
    end

    def photo(id)
      response = client.call('get', "/assets/#{id}")
      p = response.get if response.ok?
      Asset.new(p)
    end

    def tags(tag_ids)
      return if tag_ids.nil?

      response = []
      tag_ids.each do |id|
        r = client.call('get', "/entries/#{id}")

        s = r.get if r.ok?
        response << s['fields']['name']
      end
      response
    end
  end
end
