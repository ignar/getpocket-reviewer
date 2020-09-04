# typed: true
# frozen_string_literal: true

module Getpocket
  class LocalStorage
    include Singleton

    class << self
      def delete_all
        instance.delete_all
      end

      def save(article)
        instance.save(article)
      end

      def all
        instance.all.to_a
      end

      # TODO: is it used?
      def find_all(offset: 0, limit: 0)
        result = instance.all.to_a

        return result if offset == 0 && limit == 0
        return result.slice(offset, result.count) if limit == 0
        result[offset...limit]
      end
    end

    def initialize
      initialize_set
    end

    def save(article)
      @articles.add?(article)
    end

    def all
      @articles
    end

    def delete_all
      initialize_set
    end

    private

    def initialize_set
      @articles = Set.new
    end
  end
end
