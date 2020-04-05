# frozen_string_literal: true

Getpocket::Reviewer::Application.boot(:screen) do |screen|
  init do
    require 'getpocket/screens/welcome_screen'
    require 'getpocket/screens/request_token_screen'
    require 'getpocket/screens/access_token_screen'
    require 'getpocket/screens/authentication_screen'
    require 'getpocket/operations/display'
  end

  start do
    reader = TTY::Reader.new
    cursor = TTY::Cursor
    print(cursor.hide)
    print(cursor.clear_screen)

    reader.on(:keyctrl_x, :keyescape) do
      print cursor.clear_screen
      print cursor.show
      exit
    end

    # move to the run file
    @state = Getpocket::Screens::WelcomeScreen.new.process

    loop do
      @state = @state.process(reader)
    end
  end
end
