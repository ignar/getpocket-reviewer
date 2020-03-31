# frozen_string_literal: true

require 'getpocket/screens/request_token_screen'
require 'getpocket/ui/main_frame'
require 'getpocket/ui/welcome'

module Getpocket
  module Screens
    class WelcomeScreen
      def process(_ = nil)
        display
        RequestTokenScreen.new
      end

      private

      def display
        Getpocket::Operations::Display.render([
          Getpocket::UI::MainFrame,
          Getpocket::UI::Welcome,
        ])
      end
    end
  end
end
