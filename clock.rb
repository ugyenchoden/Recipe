# frozen_string_literal: true

require 'clockwork'
require 'active_support/time'

module Clockwork
  every(12.hours, 'sync recipes from CDA', at: '**:30') do
    RecipeFetcherWorker.perform_async
  end
end
