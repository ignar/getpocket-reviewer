# typed: false
# frozen_string_literal: true

Application.boot(:screen) do |screen|
  init do
    require 'getpocket/types'
    require 'getpocket/screens/welcome_screen'
    require 'getpocket/screens/request_token_screen'
    require 'getpocket/screens/access_token_screen'
    require 'getpocket/screens/authentication_screen'
    require 'getpocket/operations/display'
    require 'getpocket/screen_size'
  end

  start do
    screen.register('getpocket.screen_size', Getpocket::ScreenSize)
  end
end
