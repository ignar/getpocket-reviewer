# typed: true
# frozen_string_literal: true

require 'pstore'

module Getpocket
  module Persistance
    class Storage
      extend T::Sig

      def initialize
        @pstore = PStore.new('getpocket-articles.pstore')
      end

      sig { params(entity: Article).returns(Getpocket::Article) }
      def save(entity)
        pstore.transaction do
          pstore[:articles][entity.item_id] = entity
        end
      end

      sig { returns(T::Hash[String, Article]) }
      def all
        pstore[:articles]
      end

      private

      attr_reader :pstore
    end
  end
end
