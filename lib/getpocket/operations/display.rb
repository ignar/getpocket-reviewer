# typed: true
# frozen_string_literal: true

require 'tty-cursor'
require 'tty-screen'

module Getpocket
  module Operations
    class Display
      include Dry::Transaction::Operation

      def call(views)
        # prepare the stage
        print TTY::Cursor.move_to(0, 0)
        print TTY::Cursor.clear_lines(TTY::Screen.columns, :down)
        print TTY::Cursor.move_to(0, 0)

        views.map(&:render).join
        print TTY::Cursor.move_to(0, 0)
      end
    end
  end
end
