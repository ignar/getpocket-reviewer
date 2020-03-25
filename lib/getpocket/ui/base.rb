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

      private

      def self.cursor
        TTY::Cursor
      end

      def screen_width
        TTY::Screen.width
      end

      def screen_height
        TTY::Screen.height
      end
    end
  end
end