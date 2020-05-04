# frozen_string_literal: true

module Getpocket
  module ScreenSize
    def width
      TTY::Screen.width
    end

    def height
      TTY::Screen.height
    end

    module_function :width, :height
  end
end
