# frozen_string_literal: true

require 'tty-cursor'

module Getpocket
  module Operations
    class Display
      def self.render(views)
        views.map(&:render).join
      end
    end
  end
end