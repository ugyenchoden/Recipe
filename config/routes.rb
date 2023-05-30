# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/recipes#index'

  namespace :api do
    namespace :v1 do # rubocop:disable Naming/VariableNumber
      resources :recipes, only: %i[index show]
    end
  end
end
