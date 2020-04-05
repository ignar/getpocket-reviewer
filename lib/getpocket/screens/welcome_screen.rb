# frozen_string_literal: true

require 'getpocket/reviewer/import'

module Getpocket
  module Screens
    class WelcomeScreen
      include Import['operations.renderer']
      include Import['getpocket.ui.welcome']
      include Import['getpocket.ui.main_frame']

      def process(_ = nil)
        display
        RequestTokenScreen.new
      end

      private

      def display
        renderer.call([
          main_frame,
          welcome,
        ])
      end
    end
  end
end
