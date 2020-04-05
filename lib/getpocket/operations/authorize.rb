# frozen_string_literal: true

require 'faraday'

module Getpocket
  module Operations
    class Authorize
      include Dry::Transaction::Operation

      def call(config)
        result = Faraday.post('https://getpocket.com/v3/oauth/authorize',
                              "{\"consumer_key\": \"#{config.consumer_key}\", \"code\": \"#{config.request_token}\"}",
                              {
                                'Content-Type' => 'application/json; charset=UTF8',
                                'X-Accept' => 'application/json',
                              })
        answer = JSON.parse(result.body)
        username = answer['username']
        access_token = answer['access_token']

        Getpocket::Reviewer::AccessToken.new(
          consumer_key: config.consumer_key,
          request_token: config.request_token,
          redirect_url: config.redirect_url,
          username: username,
          access_token: access_token
        )
      end
    end
  end
end
