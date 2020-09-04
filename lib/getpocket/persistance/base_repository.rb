# typed: true
# frozen_string_literal: true

module Getpocket
  module Persistance
    class BaseRepository
      def initialize(gateway:)
        @gateway = gateway
      end

      def find_by_id(id)
        gateway.find(id)
      end

      def all
        gateway.all
      end

      def add(entity)
        gateway.add(entity)
      end

      def modify(entity)
        gateway.modify(entity)
      end

      private

      attr_reader :gateway
    end
  end
end
