# frozen_string_literal: true

class RecipeFetcherWorker < ApplicationWorker
  queue_as 'recipe_fetcher'

  def perform
    Recipes::Lister.new.run
  end
end
