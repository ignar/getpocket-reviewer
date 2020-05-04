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

      def call(offset:, per_page:)
        params = default_params.merge(count: per_page, offset: offset)

        result = Faraday.post('https://getpocket.com/v3/get',
          params.to_json,
          {
            'Content-Type' => 'application/json; charset=UTF8',
            'X-Accept' => 'application/json',
          })

        json = JSON.parse(result.body)
        return [] if json['list'].empty?

        json['list'].values.map { |entry| entry.transform_keys(&:to_sym) }
      end
    end
  end
end
