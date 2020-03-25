# frozen_string_literal: true

require 'tty-box'
require 'tty-prompt'
require 'tty-reader'

require 'getpocket/ui/main_frame'
require 'getpocket/ui/menu'
require 'getpocket/ui/list'
require 'getpocket/operations/display'

require 'getpocket/screens/welcome_screen'

module Getpocket
  module Reviewer
    class Application
      def self.run
        reader = TTY::Reader.new
        cursor = TTY::Cursor
        print cursor.hide
        print cursor.clear_screen

        @state = Getpocket::Screens::WelcomeScreen.new.process

        reader.on(:keyctrl_x, :keyescape) do
          print cursor.clear_screen
          print cursor.show
          exit
        end

        reader.on(:keypress) do |event|
          @state = @state.process(event)
        end

        loop do
          reader.read_keypress(echo: false)
        end
      end
    end
  end
end
