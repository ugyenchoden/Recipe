# frozen_string_literal: true

namespace :db do
  desc 'fetch data from CDA for initial'
  task sync_recipes: :environment do
    Recipes::Fetcher.new.run
  end
end
