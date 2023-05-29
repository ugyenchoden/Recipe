# frozen_string_literal: true

module Recipes
  module Helper
    def create_or_update_recipes(recipes, assets)
      recipe_ids = []
      recipes.each do |recipe|
        recipe_ids << recipe.id
        photo = assets.find { |asset| asset.id == recipe.photo_id }
        Recipe.find_or_initialize_by(entry_id: recipe.id).tap do |record|
          record&.recipe_tags&.destroy_all
          record.update!(recipe_attributes(recipe, photo))
        end
      end

      delete_records(recipes, 'recipe')
    end

    def create_or_update_entries(entries) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      chef_ids = []
      tag_ids = []
      entries.each do |entry|
        klass = entry.content_type.classify.constantize
        entry.content_type == 'chef' ? chef_ids << entry.id : tag_ids << entry_id
        klass.find_or_initialize_by(entry_id: entry.id).tap do |record|
          record.update!(
            name: entry.name,
            revision: entry.revision
          )
        end
      end

      delete_records(tag_ids, 'tag')
      delete_records(chef_ids, 'chef')
    end

    def delete_records(ids, klass)
      # delete chefs, tags and recipes that are no longer in content delivery api
      return if ids.empty

      klass.classify.constantize.where.not(entry_id: ids).destroy_all
    end
  end
end
