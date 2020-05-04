# frozen_string_literal: true

require 'tty-prompt'
require 'stringio'

module Getpocket
  module Ui
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
    end
  end
end
