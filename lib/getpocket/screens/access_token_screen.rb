# frozen_string_literal: true

require 'getpocket/ui/access_token'
require 'getpocket/screens/list_screen'
require 'getpocket/operations/authorize'

module Getpocket
  module Screens
    class AccessTokenScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.operations.authorize']
      include Import['getpocket.screens.list_screen']
      include Import['getpocket.ui.main_frame']
      include Import['getpocket.ui.access_token']

      attr_reader :request_token

      def [](request_token:)
        @request_token = request_token
        self
      end

      def process(reader)
        char = reader.read_keypress
        key_symbol = reader.console.keys[char]

        return self unless key_symbol == :return

        result = authorize.call(request_token)
        display.call([
          main_frame,
          access_token,
        ])

        list_screen[access_token: result, cursor_position: 0, page: 0]
      end
    end
  end
end
