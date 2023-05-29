# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    it { is_expected.to belong_to(:chef).optional(true) }
    it { is_expected.to have_one(:photo).dependent(:destroy) }
    it { is_expected.to have_many(:recipe_tags).dependent(:destroy) }
    it { is_expected.to have_many(:tags).through(:recipe_tags) }
  end

  describe 'validations' do
    # it { is_expected.to validate_presence_of(:profile) }
  end
end
