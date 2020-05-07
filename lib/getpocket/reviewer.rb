# typed: ignore
# frozen_string_literal: true

module Getpocket
  class Reviewer
    class Error < StandardError; end

    include Import['getpocket.screens.welcome_screen']

    def start
      reader = TTY::Reader.new
      cursor = TTY::Cursor
      print cursor.hide

      reader.on(:keyctrl_x, :keyescape) do
        print cursor.clear_screen
        print cursor.show
        exit
      end

      @state = welcome_screen.process

      loop do
        @state = @state.process(reader)
      end
    end
  end
end
