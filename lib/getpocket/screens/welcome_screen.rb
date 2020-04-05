# frozen_string_literal: true

require 'getpocket/reviewer/import'

module Getpocket
  module Screens
    class WelcomeScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.ui.welcome']
      include Import['getpocket.ui.main_frame']

      def process(_ = nil)
        display.call([
          main_frame,
          welcome,
        ])
        RequestTokenScreen.new
      end
    end
  end
end
