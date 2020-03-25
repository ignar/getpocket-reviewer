# frozen_string_literal: true

require 'getpocket/ui/base'

module Getpocket
  module UI
    class Authorize < Base
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
          [2, 3] => "Welcome",
          [2, 4] => "Open the next link in the browser and than press enter",
          [2, 5] => "http://google.com"
        }
      end
    end
  end
end