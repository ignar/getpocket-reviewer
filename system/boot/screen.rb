# frozen_string_literal: true

Application.boot(:screen) do |screen|
  init do
    require 'getpocket/types'
    require 'getpocket/screens/welcome_screen'
    require 'getpocket/screens/request_token_screen'
    require 'getpocket/screens/access_token_screen'
    require 'getpocket/screens/authentication_screen'
    require 'getpocket/operations/display'
  end

  start do
    # it must be a Screen class
    reader = TTY::Reader.new
    cursor = TTY::Cursor
    print cursor.hide

    reader.on(:keyctrl_x, :keyescape) do
      print cursor.clear_screen
      print cursor.show
      exit
    end

    @state = Getpocket::Screens::WelcomeScreen.new.process

    loop do
      @state = @state.process(reader)
    end
  end
end
