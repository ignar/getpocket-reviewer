# frozen_string_literal: true

module Getpocket
  module Screens
    class SynchronizationScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.screens.list_screen']
      include Import['getpocket.ui.main_frame']
      include Import['getpocket.ui.synchronization_message']
      include Import['getpocket.articles_synchronizer']

      attr_reader :access_token

      def [](access_token:)
        @access_token = access_token
        self
      end

      def process(_ = nil)
        display.call([
          main_frame,
          synchronization_message,
        ])
        # TODO: Check for a result
        articles = articles_synchronizer.call(access_token)

        list_screen[access_token: access_token, cursor_position: 0, per_page: 10]
      end
    end
  end
end
