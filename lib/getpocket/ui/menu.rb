# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class Menu < Base
      include Import['getpocket.screen_size']

      def render
        box = TTY::Box.frame(top: screen_size.height - 4, left: 2, width: screen_size.width - 4) do
          'menu'
        end
        print box
      end
    end
  end
end
