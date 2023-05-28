# frozen_string_literal: true

module Recipes
  class Tag
    def initialize(data)
      @data = data
    end

    def id
      @data['sys']['id']
    end

    def name
      @data['fields']['name']
    end
  end
end
