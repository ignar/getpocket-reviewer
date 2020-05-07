# typed: ignore
# frozen_string_literal: true

module Getpocket
  module Screens
    class WelcomeScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.screens.request_token_screen']
      include Import['getpocket.ui.welcome']
      include Import['getpocket.ui.main_frame']

      def process(_ = nil)
        display.call([
          main_frame,
          welcome,
        ])
        request_token_screen
      end
    end
  end
end
