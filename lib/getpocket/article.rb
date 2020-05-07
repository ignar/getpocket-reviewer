# typed: true
# frozen_string_literal: true

require 'getpocket/types'

module Getpocket
  class Article < Dry::Struct
    attribute :item_id, Types::Strict::String
    attribute :resolved_id, Types::Strict::String
    attribute :given_url, Types::Coercible::String
    attribute :given_title, Types::Coercible::String
    attribute :favorite, Types::Strict::String
    attribute :status, Types::Strict::String
    attribute :resolved_title, Types::Coercible::String
    attribute :resolved_url, Types::Coercible::String
    attribute :excerpt, Types::Strict::String
    attribute :is_article, Types::Strict::String
    attribute :has_video, Types::Strict::String
    attribute :has_image, Types::Strict::String
    attribute :word_count, Types::Strict::String
    attribute :images, Types::Strict::Array
    attribute :videos, Types::Strict::Array

    def hash
      item_id.hash
    end

    def eql?(other)
      self == other
    end

    def url
      given_url
    end

    def inspect
      "#<Article[item_id=#{item_id}]>"
    end
  end
end
