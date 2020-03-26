# frozen_string_literal: true

require 'getpocket/ui/authentication'
require 'getpocket/screens/access_token_screen'

module Getpocket
  module Screens
    class AuthenticationScreen
      attr_reader :request_token

      def initialize(request_token)
        @request_token = request_token
      end

      def process(_ = nil)
        display
        AccessTokenScreen.new(request_token)
      end

      private

      def display
        Getpocket::Operations::Display.render([
                                                Getpocket::UI::MainFrame,
                                                Getpocket::UI::Authentication[request_token: request_token]
                                              ])
      end
    end
  end
end
