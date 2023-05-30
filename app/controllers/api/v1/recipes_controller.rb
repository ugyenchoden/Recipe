# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def index
        @recipes = Recipe.all
      end

      def show
        @recipe = Recipe.find(params[:id])
      end
    end
  end
end
