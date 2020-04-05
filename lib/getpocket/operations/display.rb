# frozen_string_literal: true

require 'tty-cursor'

module Getpocket
  module Operations
    class Display
      include Dry::Transaction::Operation

      def call(views)
        views.map(&:render).join
      end
    end
  end
end
