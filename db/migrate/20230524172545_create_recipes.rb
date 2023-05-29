# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes, id: :uuid do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :calories
      t.string :entry_id, null: false
      t.integer :revision, null: false

      t.references :chef, type: :uuid, index: true

      t.timestamps
    end

    add_index :recipes, :entry_id, unique: true
  end
end
