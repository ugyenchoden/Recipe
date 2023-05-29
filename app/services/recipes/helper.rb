# frozen_string_literal: true

module Recipes
  module Helper
    def create_or_update_recipes(recipes, assets) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      recipes.each do |recipe|
        photo = assets.find { |asset| asset.id == recipe.photo_id }
        chef = Chef.find_by(entry_id: recipe&.chef_id)
        Recipe.find_or_initialize_by(entry_id: recipe.id).tap do |record|
          record&.recipe_tags&.destroy_all
          record.update!(
            title: recipe.title,
            revision: recipe.revision,
            description: recipe.description,
            calories: recipe&.calories,
            asset_attributes: asset_attributes(photo),
            recipe_tags_attributes: recipe_tags_attributes(recipe.tag_ids),
            chef_id: chef&.id
          )
        end
      end
    end

    def create_or_update_entries(entries)
      entries.each do |entry|
        klass = entry.content_type.classify.constantize
        klass.find_or_initialize_by(entry_id: entry.id).tap do |record|
          record.update!(
            name: entry.name,
            revision: entry.revision
          )
        end
      end
    end
  end
end
