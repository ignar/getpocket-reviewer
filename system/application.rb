# typed: strict
# frozen_string_literal: true

class Application < Dry::System::Container
  configure do |config|
    config.name = :getpocket
    config.auto_register = %w(lib)
  end

  load_paths!('lib')

  register('link_opener', Launchy)
end
