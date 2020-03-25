# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module UI
    class Menu < Base
      def view
        box = TTY::Box.frame(top: screen_height - 4, left: 2, width: screen_width - 4) do
          'menu'
        end
        print box
      end
    end
  end
end