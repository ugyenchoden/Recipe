# frozen_string_literal: true

class CreateChefs < ActiveRecord::Migration[7.0]
  def change
    create_table :chefs, id: :uuid do |t|
      t.string :name, null: false
      t.string :entry_id, null: false
      t.integer :revision, null: false

      t.timestamps
    end
  end
end
