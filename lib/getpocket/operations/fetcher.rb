# frozen_string_literal: true
module Getpocket
  module Operations
    class Fetcher
      attr_reader :config, :default_params

      def initialize(config)
        @config = config
        @default_params = {
          consumer_key: config.consumer_key,
          access_token: config.access_token,
          detailType: 'simple',
          sort: 'oldest',
        }
      end

      def call(since: nil, per_page:)
        params = default_params.merge(count: per_page)
        params = params.merge(since: since) if since

        result = Faraday.post('https://getpocket.com/v3/get',
          params.to_json,
          {
            'Content-Type' => 'application/json; charset=UTF8',
            'X-Accept' => 'application/json',
          })

        json = JSON.parse(result.body)
        json['list'].values
      end
    end
  end
end
