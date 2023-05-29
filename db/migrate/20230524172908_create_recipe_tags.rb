# frozen_string_literal: true

class CreateRecipeTags < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_tags, id: :uuid do |t|
      t.references :recipe, type: :uuid, null: false, index: true
      t.references :tag, type: :uuid, null: false, index: true

      t.timestamps
    end

    add_index :recipe_tags, %i[recipe_id tag_id], unique: true
  end
end
