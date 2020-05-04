# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class MainFrame < Base
      include Import['getpocket.screen_size']

      def render
        print TTY::Box.frame(top: 0, left: 0, width: screen_size.width, height: screen_size.height) do
          'text '
        end
      end
    end
  end
end
