# frozen_string_literal: true

require 'rails_helper'

describe Recipes::Fetcher do
  context 'with valid request' do
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

  context 'with invalid request' do
    context 'with SPACE_ID env not set properly' do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('SPACE_ID').and_return(nil)
      end

      it 'throws argument error' do
        expect { ContentDelivery::ApiClient.new }.to raise_error(ArgumentError, 'Add SPACE_ID in .env')
      end
    end

    context 'with AUTH_TOKEN env not set properly' do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('AUTH_TOKEN').and_return(nil)
      end

      it 'throws argument error' do
        expect { ContentDelivery::ApiClient.new }.to raise_error(ArgumentError, 'Add AUTH_TOKEN in .env')
      end
    end
  end
end
