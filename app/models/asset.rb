# frozen_string_literal: true

class Asset < ApplicationRecord
  belongs_to :recipe
end
