# frozen_string_literal: true

require 'rails_helper'

describe Recipes::Fetcher do
  before do
    Recipes::TagsFetcher.new.run
    Recipes::ChefsFetcher.new.run
  end

  it 'creates recipes with their associations' do
    described_class.new.run
    expect(Recipe.count).to be(4)
    expect(Photo.count).to be(4)
  end
end
