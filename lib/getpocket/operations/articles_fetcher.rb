# frozen_string_literal: true

module Getpocket
  module Operations
    class ArticlesFetcher
      include Enumerable
      include Singleton

      attr_reader :config, :offset, :old_offset, :collection

      PER_PAGE = 10

      def prepare(config, page)
        @config = config
        @offset = page * PER_PAGE
      end

      def each(&block)
        fetch_page
        @collection.each { |el| block.call(el) }
      end

      private

      def fetch_page
        return if offset == old_offset

        @old_offset = offset
        result = Faraday.post('https://getpocket.com/v3/get',
                              {
                                consumer_key: config.consumer_key,
                                access_token: config.access_token,
                                count: PER_PAGE,
                                detailType: 'simple',
                                sort: 'oldest',
                                offset: offset
                              }.to_json,
                              {
                                'Content-Type' => 'application/json; charset=UTF8',
                                'X-Accept' => 'application/json'
                              })
        json = JSON.parse(result.body)
        @collection = json['list'].values
      end
    end
  end
end
