# frozen_string_literal: true

require "tty-prompt"
require 'stringio'

module Getpocket
  module UI
    class Base
      def self.render
        new.view
      end

      def view
        raise NotImplementedError
      end

      def cursor
        TTY::Cursor
      end

      private

      def screen_width
        TTY::Screen.width
      end

      def screen_height
        TTY::Screen.height
      end
    end
  end
end