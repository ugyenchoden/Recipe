# frozen_string_literal: true

module Recipes
  module AttributesHelper
    def recipe_tags_attributes(tag_ids)
      return [] if tag_ids.nil?

      tag_ids.map do |tag_id|
        tag = Tag.find_by(entry_id: tag_id)
        { tag_id: tag.id }
      end
    end

    def recipe_attributes(recipe, photo)
      chef = Chef.find_by(entry_id: recipe&.chef_id)
      {
        title: recipe.title,
        revision: recipe.revision,
        description: recipe.description,
        calories: recipe&.calories,
        asset_attributes: asset_attributes(photo),
        recipe_tags_attributes: recipe_tags_attributes(recipe.tag_ids),
        chef_id: chef&.id
      }
    end

    def asset_attributes(photo)
      {
        entry_id: photo.id,
        revision: photo.revision,
        title: photo.title,
        file_url: photo.file_url,
        filename: photo.filename
      }
    end
  end
end
