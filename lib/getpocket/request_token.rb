# frozen_string_literal: true

module Getpocket
  module Reviewer
    class RequestToken < Dry::Struct::Value
      attribute :consumer_key, Types::Strict::String
      attribute :request_token, Types::String.default('')
      attribute :redirect_url, Types::Strict::String
    end
  end
end
