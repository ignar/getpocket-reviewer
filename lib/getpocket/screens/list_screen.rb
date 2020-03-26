# frozen_string_literal: true

module Getpocket
  module Screens
    class ListScreen
      attr_reader :cursor_position

      def initialize(cursor_position:)
        @cursor_position = cursor_position
      end

      def process(reader)
        display

        char = reader.read_keypress
        key_symbol = reader.console.keys[char]

        if key_symbol == :up
          return ListScreen.new(cursor_position: cursor_position - 1).display
        end

        if key_symbol == :down
          ListScreen.new(cursor_position: cursor_position + 1).display
        end
      end

      def display
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