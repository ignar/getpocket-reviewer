# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module Ui
    class RequestToken < Base
      def self.render
        new.tap do |instance|
          instance.view.each do |position, line|
            row, column = position
            print instance.cursor.move_to(row, column)
            print line
          end
        end
      end

      def view
        {
          [2, 3] => 'Welcome',
          [2, 4] => 'To the GetPocket CLI client',
          [2, 5] => 'Authenticating application',
        }
      end
    end
  end
end
