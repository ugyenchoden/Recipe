# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chef do
  describe 'associations' do
    it { is_expected.to have_many(:recipes).dependent(:nullify) }
  end

  describe 'validations' do
    # it { is_expected.to validate_presence_of(:profile) }
  end
end
