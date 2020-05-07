# typed: strict
# frozen_string_literal: true

require 'bundler/setup'
require 'webmock/rspec'

require 'simplecov'
SimpleCov.start

require_relative '../system/boot'
Application.start(:getpocket_api)
Application.start(:screen)

require 'dry/system/stubs'

Dir[File.expand_path(File.join('lib', '**', '*.rb'))].each { |f| require f }

Application.enable_stubs!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end
end
