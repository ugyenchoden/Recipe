# frozen_string_literal: true

require 'rails_helper'
require 'rails-dom-testing'

module Api
  module V1
    describe RecipesController, '#index' do
      let_it_be(:recipe) { create(:recipe) }

      before do
        allow_any_instance_of(ActionView::Helpers::AssetTagHelper).to receive(:image_tag).and_return('<img src="https://loremflickr.com/300/300">')
      end

      context 'without paginations' do
        it 'returns recipes' do
          get '/api/v1/recipes'
          expect(status).to eq(200)
          expect(response).to render_template(:index)
          expect(response.body).to include(recipe.title)
        end
      end
    end
  end
end
