# frozen_string_literal: true

require 'faraday'

module Getpocket
  module Operations
    class Authorize
      AccessToken = Struct.new(:consumer_key, :request_token, :redirect_url, :username, :access_token)

      def self.authorize(config)
        result = Faraday.post('https://getpocket.com/v3/oauth/authorize',
          "{\"consumer_key\": \"#{config.consumer_key}\", \"code\": \"#{config.request_token}\"}",
          {
            'Content-Type' => 'application/json; charset=UTF8',
            'X-Accept' => 'application/json'
          })
        answer = JSON.parse(result.body)
        username = answer['username']
        access_token = answer['access_token']

        AccessToken.new(config.consumer_key, config.request_token, config.redirect_url, username, access_token)
      end
    end
  end
end