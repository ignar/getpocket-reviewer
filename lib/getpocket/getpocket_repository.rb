# typed: ignore
# frozen_string_literal: true

require 'pstore'

module Getpocket
  class GetpocketRepository
    include Import['getpocket.operations.fetcher']
    include Import['getpocket.article']
    include Import['getpocket.database']

    attr_reader :config

    def [](config:)
      @config = config
      self
    end

    def add
      raise NotImplementedError
    end

    def modify
      raise NotImplementedError
    end

    def retrieve(offset: nil, per_page:)
      result = fetcher.new(config).call(offset: offset, per_page: per_page)
      database.transaction do
        # TODO: mapper function or class
        result.map do |entry|
          article.new(
            item_id: entry[:item_id],
            resolved_id: entry[:resolved_id],
            given_url: entry[:given_url],
            given_title: entry[:given_title],
            favorite: entry[:favorite],
            status: entry[:status],
            resolved_title: entry[:resolved_title],
            resolved_url: entry[:resolved_url],
            excerpt: entry[:excerpt],
            is_article: entry[:is_article],
            has_video: entry[:has_video],
            has_image: entry[:has_image],
            word_count: entry[:word_count],
            images: [],
            videos: []
          ).tap do
            # TODO: Refactor & cover with tests
            database[:main] = {} unless database[:main]
            database[:main] = database[:main][_1.item_id] = _1.to_hash
            yield(_1) if block_given?
          end
        end
      end
    end
  end
end
