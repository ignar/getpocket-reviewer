# typed: true
# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class List < Base
      attr_reader :collection, :cursor_position

      def [](collection:, cursor_position:)
        @collection = collection
        @cursor_position = cursor_position
        self
      end

      def render
        view.each do |position, line|
          row, column = position
          print cursor.move_to(row, column)
          print line
        end
      end

      def view
        row = 2
        collection_with_position = collection.map.with_index do |line, index|
          row += 1
          item = index == cursor_position ? "> #{line.resolved_title}" : "  #{line.resolved_title}"
          [[2, row], item]
        end
        collection_with_position.to_h
      end
    end
  end
end
