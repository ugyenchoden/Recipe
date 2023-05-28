# frozen_string_literal: true

class ChefFetcherWorker < ApplicationWorker
  queue_as 'chef_fetcher'

  def perform
    Recipes::ChefsFetcher.new.call
  end
end
