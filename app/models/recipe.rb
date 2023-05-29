# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :chef, optional: true
  has_one :asset, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  accepts_nested_attributes_for :asset, :recipe_tags

  delegate :name, to: :chef, allow_nil: true
  delegate :filename, :file_url, to: :asset
  delegate :revision, to: :asset, prefix: true
end
