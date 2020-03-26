# frozen_string_literal: true

require 'getpocket/ui/access_token'
require 'getpocket/screens/list_screen'
require 'getpocket/operations/authorize'

module Getpocket
  module Screens
    class AccessTokenScreen
      attr_reader :request_token

      def initialize(request_token)
        @request_token = request_token
      end

      def process(_ = nil)
        Operations::Authorize.authorize(request_token)
        display
        ListScreen.new(cursor_position: 0)
      end

      private

      def display
        Getpocket::Operations::Display.render([
          Getpocket::UI::MainFrame,
          Getpocket::UI::AccessToken
        ])
      end
    end
  end
end