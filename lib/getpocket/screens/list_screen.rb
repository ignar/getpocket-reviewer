# frozen_string_literal: true

require 'getpocket/operations/articles_fetcher'

module Getpocket
  module Screens
    class ListScreen
      attr_reader :cursor_position, :access_token, :page

      def initialize(access_token:, cursor_position:, page:)
        @access_token = access_token
        @cursor_position = cursor_position
        @page = page
      end

      def process(reader)
        display

        char = reader.read_keypress
        key_symbol = reader.console.keys[char]

        if key_symbol == :right
          return ListScreen.new(access_token: access_token, cursor_position: 0, page: page + 1)
        end

        if key_symbol == :left
          return ListScreen.new(access_token: access_token, cursor_position: 0, page: page - 1)
        end

        if key_symbol == :up
          return ListScreen.new(access_token: access_token, cursor_position: cursor_position - 1, page: page)
        end

        if key_symbol == :down
          ListScreen.new(access_token: access_token, cursor_position: cursor_position + 1, page: page)
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

        ListScreen.new(access_token: access_token, cursor_position: cursor_position, page: page)
      end

      private

      def collection
        Operations::ArticlesFetcher.instance.tap do |instance|
          instance.prepare(access_token, page)
        end
      end
    end
  end
end
