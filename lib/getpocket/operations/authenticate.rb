# frozen_string_literal: true

require 'faraday'

require 'getpocket/reviewer/import'

module Getpocket
  module Operations
    class Authenticate
      include Dry::Transaction::Operation
      include Import['configuration.client_configuration']

      def call
        result = Faraday.post('https://getpocket.com/v3/oauth/request',
          "{\"consumer_key\": \"#{client_configuration.consumer_key}\", \"redirect_uri\": \"#{client_configuration.redirect_url}\"}",
          {
            'Content-Type' => 'application/json; charset=UTF8',
            'X-Accept' => 'application/json',
          })
        code = JSON.parse(result.body)['code']

        Getpocket::Reviewer::RequestToken.new(
          consumer_key: client_configuration.consumer_key,
          request_token: code,
          redirect_url: client_configuration.redirect_url
        )
      end
    end
  end
end
