# frozen_string_literal: true

module Getpocket
  module Screens
    class RequestTokenScreen
      include Import['getpocket.operations.authenticate']
      include Import['getpocket.operations.display']
      include Import['getpocket.screens.authentication_screen']
      include Import['getpocket.ui.main_frame']
      include Import['getpocket.ui.request_token']

      def process(_ = nil)
        result = authenticate.call
        display.call([
          main_frame,
          request_token,
        ])
        authentication_screen[request_token: result]
      end
    end
  end
end
