# frozen_string_literal: true

class TagFetcherWorker < ApplicationWorker
  queue_as 'tag_fetcher'

  def perform
    Recipes::TagsFetcher.new.run
  end
end
