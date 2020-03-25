# frozen_string_literal: true

require 'tty-box'
require 'tty-prompt'
require 'tty-reader'

require 'getpocket/ui/main_frame'
require 'getpocket/ui/menu'
require 'getpocket/ui/list'
require 'getpocket/operations/display'

module Getpocket
  module Reviewer
    class Application
      def self.run
        reader = TTY::Reader.new
        cursor = TTY::Cursor
        print cursor.hide
        print cursor.clear_screen

        Getpocket::Operations::Display.render([
          Getpocket::UI::MainFrame,
          Getpocket::UI::Menu,
          Getpocket::UI::List,
        ])

        reader.on(:keyctrl_x, :keyescape) do
          print cursor.clear_screen
          print cursor.show
          exit
        end

        loop do
          p reader.read_keypress(echo: false)
        end
      end
    end
  end
end
