# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def index
        @recipes = Recipes::Fetcher.new.run
      end

      def show
        @recipe = Recipes::Finder.new(id: params[:id]).run
      end
    end
  end
end
