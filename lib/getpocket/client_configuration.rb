# typed: strict
# frozen_string_literal: true

module Getpocket
  class ClientConfiguration < Dry::Struct
    attribute :consumer_key, Types::Strict::String
    attribute :redirect_url, Types::Strict::String
  end
end
