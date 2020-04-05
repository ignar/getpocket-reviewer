# frozen_string_literal: true

module Getpocket
  module Screens
    class AuthenticationScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.ui.authentication']
      include Import['getpocket.ui.main_frame']

      attr_accessor :request_token

      def process(_ = nil)
        display
        AccessTokenScreen.new(request_token)
      end

      private

      def display
        renderer.call([
          main_frame,
          authentication[request_token: request_token],
        ])
      end
    end
  end
end
