# frozen_string_literal: true

require 'tty-box'
require 'tty-prompt'
require 'tty-reader'

require 'dry/system/container'

require 'getpocket/ui/main_frame'
require 'getpocket/ui/menu'
require 'getpocket/ui/list'
require 'getpocket/operations/display'

module Getpocket
  module Reviewer
    class Application < Dry::System::Container
      configure do |config|
        config.root = Pathname(File.absolute_path(File.join(__dir__, '..', '..', '..')))
        config.auto_register = 'lib'
      end

      load_paths!('lib')
    end
  end
end
