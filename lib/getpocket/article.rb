# frozen_string_literal: true

module Getpocket
  class Article < Dry::Struct::Value
    attribute :item_id, Types::Strict::String
    attribute :resolved_id, Types::Strict::String
    attribute :given_url, Types::Strict::String
    attribute :given_title, Types::Strict::String
    attribute :favorite, Types::Strict::String
    attribute :status, Types::Strict::String
    attribute :resolved_title, Types::Strict::String
    attribute :resolved_url, Types::Strict::String
    attribute :excerpt, Types::Strict::String
    attribute :is_article, Types::Strict::String
    attribute :has_video, Types::Strict::String
    attribute :has_image, Types::Strict::String
    attribute :word_count, Types::Strict::String
    attribute :images, Types::Strict::Array
    attribute :videos, Types::Strict::Array
  end
end
