# frozen_string_literal: true

module Getpocket
  module Operations
    class ArticlesFetcher
      include Enumerable

      attr_reader :config, :offset

      PER_PAGE = 10

      def initialize(config, page)
        @config = config
        @offset = (page - 1) * PER_PAGE
        @collection = []
      end

      def each(&block)
        page = fetch_page
        page.each { |el| block.call(el) }
      end

      private

      def fetch_page
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
        json['list'].values
      end
    end
  end
end