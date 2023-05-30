# frozen_string_literal: true

require 'rails_helper'

describe Recipes::Fetcher do
  it 'creates recipes with their associations' do # rubocop:disable RSpec/MultipleExpectations
    stub_content_delivery_api

    described_class.new.run

    expect(Recipe.count).to be(1)
    expect(Asset.count).to be(1)
    expect(Tag.count).to be(1)
    expect(Chef.count).to be(1)

    recipe = Recipe.take
    expect(recipe.title).to eq('Ema Datsi')
    expect(recipe.tags.pluck(:name)).to contain_exactly('vegan')
    expect(recipe.name).to eq('Ugyen Choden')
  end
end
