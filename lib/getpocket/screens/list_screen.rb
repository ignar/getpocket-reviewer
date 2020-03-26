# frozen_string_literal: true

module Getpocket
  module Screens
    class ListScreen
      attr_reader :cursor_position

      def initialize(cursor_position:)
        @cursor_position = cursor_position
      end

      def process(event)
        if event.key.name == :up
          return ListScreen.new(cursor_position: cursor_position - 1).display_list
        end

        if event.key.name == :down
          return ListScreen.new(cursor_position: cursor_position + 1).display_list
        end

        display_list
      end

      def display_list
        Getpocket::Operations::Display.render([
          Getpocket::UI::MainFrame,
          Getpocket::UI::Menu,
          Getpocket::UI::List[
            cursor_position: cursor_position,
            collection: ['line 1', 'line 2', 'line 3']
          ]
        ])

        ListScreen.new(cursor_position: cursor_position)
      end
    end
  end
end