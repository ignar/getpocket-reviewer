# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class Authentication < Base
      attr_reader :request_token

      # def self.[](args)
      #   new(request_token: args.fetch(:request_token))
      # end

      # def initialize(request_token:)
      #   @request_token = request_token
      # end

      def render
        view.each do |position, line|
          row, column = position
          print cursor.move_to(row, column)
          print line
        end
      end

      def view
        {
          [2, 3] => 'Welcome',
          [2, 4] => 'To the GetPocket CLI client',
          [2, 5] => 'Authenticating application',
          [2, 6] => 'Open URL and press enter once succeed:',
          [2, 7] => "https://getpocket.com/auth/authorize?request_token=#{request_token.request_token}&redirect_uri=#{request_token.redirect_url}",
        }
      end
    end
  end
end
