# frozen_string_literal: true

module Getpocket
  module Screens
    class LoadingScreen
      def process

        ArticlesFetcher.new(Config.new('90239-d5cc68bdb01dc9ea77d3bef0', ))
      end
    end

    Config = Struct.new(:consumer_key, :access_token)

    class ArticlesFetcher
      include Enumerable

      attr_reader :config
      attr_accessor :offset, :collection

      PER_PAGE = 10

      def initialize(config)
        @config = config
        @offset = 0
        @collection = []
      end

      def each(&block)
        while page = fetch_batch
          page.each { |el| block.call(el) }
        end
      end

      def each_mapped(mapper)
        enum = ArticlesEnumerator.new do |yielder|
          each do |element|
            yielder << mapper.map(element)
          end
        end
        enum.each { |element| yield element } if block_given?
        enum
      end

      def fetch_batch

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
        self.offset += PER_PAGE
        json = JSON.parse(result.body)

        return false if json['list'].count == 0

        collection.append(*json['list'].values)
        json['list'].values
      end
    end
  end
end