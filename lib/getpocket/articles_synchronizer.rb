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
      # TODO: move this down to getpocker repository
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

    # TODO: replace call with _call
    def _call(config)
      local = LocalRepository.new
      GetpocketRepository.new.retrieve.each do |article|
        local.add(article)
      end
    end
  end
end

# Repository <- Gateway (Storage)
# Service <- Mapper
