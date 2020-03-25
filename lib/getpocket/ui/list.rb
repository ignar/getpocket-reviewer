# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module UI
    class List < Base
      def self.render
        new.view.each do |position, line|
          row, column = position
          print cursor.move_to(row, column)
          print line
        end
      end

      def view
        {
          [2, 3] => "line 1",
          [2, 4] => "line 2"
        }
      end
    end
  end
end