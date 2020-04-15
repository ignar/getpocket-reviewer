# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class MainFrame < Base
      def render
        print TTY::Box.frame(top: 0, left: 0, width: screen_width, height: screen_height) do
          'text '
        end
      end
    end
  end
end
