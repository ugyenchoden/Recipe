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
