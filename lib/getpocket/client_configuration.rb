# frozen_string_literal: true

module Getpocket
  module Reviewer
    class ClientConfiguration < Dry::Struct::Value
      attribute :consumer_key, Types::Strict::String
      attribute :redirect_url, Types::Strict::String
    end
  end
end
