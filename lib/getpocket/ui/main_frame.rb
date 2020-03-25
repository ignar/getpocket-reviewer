# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module UI
    class MainFrame < Base
      def view
        print TTY::Box.frame(top: 0, left: 0, width: screen_width, height: screen_height) do
          'text '
        end
      end
    end
  end
end