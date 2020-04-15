# frozen_string_literal: true

module Getpocket
  module Reviewer
    class AccessToken < Dry::Struct
      attribute :consumer_key, Types::Strict::String
      attribute :request_token, Types::Strict::String
      attribute :redirect_url, Types::Strict::String
      attribute :username, Types::Strict::String
      attribute :access_token, Types::Strict::String
    end
  end
end
