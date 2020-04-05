# frozen_string_literal: true

module Getpocket
  module Screens
    class AuthenticationScreen
      include Import['getpocket.operations.display']
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
        AccessTokenScreen.new(request_token)
      end
    end
  end
end
