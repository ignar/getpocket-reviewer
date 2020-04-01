# frozen_string_literal: true

require 'faraday'

module Getpocket
  module Operations
    class Authenticate
      include Dry::Transaction::Operation

      def call(config)
        result = Faraday.post('https://getpocket.com/v3/oauth/request',
          "{\"consumer_key\": \"#{config.consumer_key}\", \"redirect_uri\": \"#{config.redirect_url}\"}",
          {
            'Content-Type' => 'application/json; charset=UTF8',
            'X-Accept' => 'application/json',
          })
        code = JSON.parse(result.body)['code']

        Getpocket::Reviewer::RequestToken.new(consumer_key: config.consumer_key, request_token: code, redirect_url: config.redirect_url)
      end
    end
  end
end
