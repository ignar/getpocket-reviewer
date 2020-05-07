# typed: true
# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class Welcome < Base
      def render
        views.each do |position, line|
          row, column = position
          print cursor.move_to(row, column)
          print line
        end
      end

      def views
        {
          [2, 3] => 'Welcome',
          [2, 4] => 'To the GetPocket CLI client',
        }
      end
    end
  end
end
