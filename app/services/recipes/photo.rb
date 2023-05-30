# frozen_string_literal: true

module Recipes
  class Photo
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

    def revision
      @data['sys']['revision']
    end

    def filename
      @data['fields']['file']['fileName']
    end
  end
end
