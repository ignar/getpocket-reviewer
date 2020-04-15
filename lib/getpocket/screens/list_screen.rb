# frozen_string_literal: true

require 'getpocket/operations/articles_fetcher'

module Getpocket
  module Screens
    class ListScreen
      include Import['getpocket.operations.display']
      include Import['getpocket.local_repository']
      include Import['getpocket.ui.main_frame']
      include Import['getpocket.ui.menu']
      include Import['getpocket.ui.list']

      attr_reader :cursor_position, :access_token, :first_element, :per_page

      def [](access_token:, per_page:, cursor_position: 0, first_element: nil)
        @access_token = access_token
        @cursor_position = cursor_position
        @first_element = first_element
        @per_page = per_page
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

        # TODO: use parameter object
        # TODO refactor

        if key_symbol == :up
          if cursor_position == 0
            return self.class.new[
              access_token: access_token,
              cursor_position: cursor_position,
              per_page: per_page,
              first_element: previous_element
            ]
          else
            return self.class.new[
              access_token: access_token,
              cursor_position: cursor_position - 1,
              per_page: per_page,
              first_element: collection.first
            ]
          end
        end

        if key_symbol == :down
          # TODO: hold situation when it is the last element in the whole collection
          if cursor_position == per_page
            return self.class.new[
              access_token: access_token,
              cursor_position: cursor_position,
              per_page: per_page,
              first_element: next_element
            ]
          else
            @cursor_position += 1
            return self.class.new[
              access_token: access_token,
              cursor_position: cursor_position,
              per_page: per_page,
              first_element: collection.first
            ]
          end
        end

        # TODO: test this line
        self
      end

      private

      def collection
        # TODO: use first article identifier of the page, page number (?), per page
        local_repository.retrieve(per_page: per_page, first_element: first_element)
      end

      # TODO: does not belong here, feature envy
      def previous_element
        local_repository.previous(collection.first)
      end

      def next_element
        collection[1]
      end
    end
  end
end
