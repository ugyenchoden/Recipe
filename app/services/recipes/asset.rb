# frozen_string_literal: true

module Recipes
  class Asset
    def initialize(data)
      @data = data
    end

    def id
      @data['sys']['id']
    end

    def title
      @data['fields']['title']
    end

    def file_url
      @data['fields']['file']['url']
    end
  end
end
