# typed: true
# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class SynchronizationMessage < Base
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
          [2, 5] => 'Synchronizing articles',
        }
      end
    end
  end
end
