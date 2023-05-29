# frozen_string_literal: true

class RecipeFetcherWorker < ApplicationWorker
  queue_as 'recipe_fetcher'

  def perform
    Recipes::Fetcher.new.run
  end
end
