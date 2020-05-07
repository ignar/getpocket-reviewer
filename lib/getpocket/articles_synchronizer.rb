# typed: ignore
# frozen_string_literal: true

module Getpocket
  class ArticlesSynchronizer
    include Import[
      'getpocket.getpocket_repository',
      'getpocket.local_repository'
    ]

    def call(config)
      collection = []
      offset = 0
      getpocket_repository[config: config]
      result = getpocket_repository.retrieve(per_page: 100, offset: offset)
      until result.empty?
        collection << result
        offset += 100
        result = getpocket_repository.retrieve(per_page: 100, offset: offset)
      end
      collection.flatten.each do |entry|
        local_repository.save(entry)
      end
    end
  end
end
