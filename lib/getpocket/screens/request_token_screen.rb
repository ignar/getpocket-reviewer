# frozen_string_literal: true

require 'getpocket/screens/authentication_screen'
require 'getpocket/ui/main_frame'
require 'getpocket/ui/request_token'
require 'getpocket/operations/authenticate'

module Getpocket
  module Screens
    class RequestTokenScreen
      def process(_ = nil)
        request_token = Operations::Authenticate.authenticate
        display
        AuthenticationScreen.new(request_token)
      end

      private

      def display
        Getpocket::Operations::Display.render([
                                                Getpocket::UI::MainFrame,
                                                Getpocket::UI::RequestToken
                                              ])
      end
    end
  end
end
