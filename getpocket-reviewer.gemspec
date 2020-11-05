# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'getpocket/reviewer/version'

Gem::Specification.new do |spec|
  spec.name          = 'getpocket-reviewer'
  spec.version       = Getpocket::Reviewer::VERSION
  spec.authors       = ['Artem Melnykov']
  spec.email         = ['melnykov.artem.v@gmail.com']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://artem.melnykov.dev'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency('bundler', '~> 2.0')
  spec.add_development_dependency('rake', '~> 13.0')
  spec.add_development_dependency('rspec', '~> 3.10')
  spec.add_development_dependency('rubocop', '~> 0.80')
  spec.add_development_dependency('rubocop-shopify', '~> 1.0')
  spec.add_development_dependency('rubocop-rspec', '~> 1.38')
  spec.add_development_dependency('webmock', '~> 3.8.3')
  spec.add_development_dependency('pry-byebug', '~> 3.9')

  spec.add_dependency('dry-system', '~> 0.18')
  spec.add_dependency('dry-struct', '~> 1.3')
  spec.add_dependency('dry-types', '~> 1.4')
  spec.add_dependency('dry-transaction', '~> 0.13')
  spec.add_dependency('faraday', '~> 1.0')
  spec.add_dependency('tty-box', '~> 0.5')
  spec.add_dependency('tty-prompt', '~> 0.21')
  spec.add_dependency('tty-reader', '~> 0.7')
  spec.add_dependency('tty-screen', '~> 0.7')
  spec.add_dependency('launchy', '~> 2.5')
end
