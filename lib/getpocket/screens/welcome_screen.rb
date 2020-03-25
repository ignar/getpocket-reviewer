# frozen_string_literal: true

require 'getpocket/screens/list_screen'
require 'getpocket/ui/main_frame'
require 'getpocket/ui/authorize'

module Getpocket
  module Screens
    class WelcomeScreen
      def process(_ = nil)
        authorize
      end

      def authorize
        Getpocket::Operations::Display.render([
          Getpocket::UI::MainFrame,
          Getpocket::UI::Authorize
        ])

        ListScreen.new(cursor_position: 0)
      end
    end
  end
end