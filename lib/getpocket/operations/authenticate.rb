# frozen_string_literal: true

require 'faraday'

module Getpocket
  module Operations
    class Authenticate
      Config = Struct.new(:consumer_key, :redirect_url)
      RequestToken = Struct.new(:consumer_key, :request_token, :redirect_url)

      def self.authenticate
        config = Config.new('90239-d5cc68bdb01dc9ea77d3bef0', 'ruby-cli:authorizationFinished')

        result = Faraday.post('https://getpocket.com/v3/oauth/request',
                              "{\"consumer_key\": \"#{config.consumer_key}\", \"redirect_uri\": \"#{config.redirect_url}\"}",
                              {
                                'Content-Type' => 'application/json; charset=UTF8',
                                'X-Accept' => 'application/json'
                              })
        code = JSON.parse(result.body)['code']

        RequestToken.new(config.consumer_key, code, config.redirect_url)
      end
    end
  end
end
