# frozen_string_literal: true

class CreateAssets < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :assets, id: :uuid do |t|
      t.string :title, null: false
      t.string :filename, null: false
      t.string :file_url, null: false
      t.jsonb :metadata, default: {}
      t.string :entry_id, null: false
      t.integer :revision, null: false

      t.references :recipe, type: :uuid, index: true, null: false

      t.timestamps
    end

    add_index :assets, :entry_id, unique: true
  end
end
