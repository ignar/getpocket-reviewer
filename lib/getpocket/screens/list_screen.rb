# frozen_string_literal: true

require 'getpocket/operations/articles_fetcher'

module Getpocket
  module Screens
    class ListScreen
      attr_reader :cursor_position, :access_token

      def initialize(access_token:, cursor_position:)
        @access_token = access_token
        @cursor_position = cursor_position
      end

      def process(reader)
        display

        char = reader.read_keypress
        key_symbol = reader.console.keys[char]

        if key_symbol == :up
          return ListScreen.new(access_token: access_token, cursor_position: cursor_position - 1).display
        end

        if key_symbol == :down
          ListScreen.new(access_token: access_token, cursor_position: cursor_position + 1).display
        end
      end

      def display
        Getpocket::Operations::Display.render([
          Getpocket::UI::MainFrame,
          Getpocket::UI::Menu,
          Getpocket::UI::List[
            cursor_position: cursor_position,
            collection: collection
          ]
        ])

        ListScreen.new(access_token: access_token, cursor_position: cursor_position)
      end

      private

      def collection
        Operations::ArticlesFetcher.new(access_token, 1)
      end
    end
  end
end