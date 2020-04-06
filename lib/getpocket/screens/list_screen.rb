# frozen_string_literal: true

require 'getpocket/operations/articles_fetcher'

module Getpocket
  module Screens
    class ListScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.operations.articles_fetcher']
      include Import['getpocket.ui.main_frame']
      include Import['getpocket.ui.menu']
      include Import['getpocket.ui.list']

      attr_reader :cursor_position, :access_token, :page

      def [](access_token:, cursor_position:, page:)
        @access_token = access_token
        @cursor_position = cursor_position
        @page = page
        self
      end

      def process(reader)
        display.call([
          main_frame,
          menu,
          list[
            cursor_position: cursor_position,
            collection: collection
          ],
        ])

        char = reader.read_keypress
        key_symbol = reader.console.keys[char]

        if key_symbol == :right
          return self.class.new[access_token: access_token, cursor_position: 0, page: page + 1]
        end

        if key_symbol == :left
          return self.class.new[access_token: access_token, cursor_position: 0, page: page - 1]
        end

        if key_symbol == :up
          return self.class.new[access_token: access_token, cursor_position: cursor_position - 1, page: page]
        end

        if key_symbol == :down
          self.class.new[access_token: access_token, cursor_position: cursor_position + 1, page: page]
        end
      end

      private

      def collection
        articles_fetcher.instance.tap do |instance|
          instance.prepare(access_token, page)
        end
      end
    end
  end
end
