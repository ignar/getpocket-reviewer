# typed: ignore
# frozen_string_literal: true

module Getpocket
  module Screens
    class AuthenticationScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.screens.access_token_screen']
      include Import['getpocket.ui.authentication']
      include Import['getpocket.ui.main_frame']

      attr_accessor :request_token

      def [](request_token:)
        @request_token = request_token
        self
      end

      def process(_ = nil)
        display.call([
          main_frame,
          authentication[request_token: request_token],
        ])
        access_token_screen[request_token: request_token]
      end
    end
  end
end
