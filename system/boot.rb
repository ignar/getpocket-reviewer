# typed: strong
# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup'

require 'launchy'

require 'tty-box'
require 'tty-prompt'
require 'tty-reader'

require 'dry/system/container'
require 'dry/transaction'
require "dry/transaction/operation"

require_relative 'application'
require_relative 'import'
require_relative 'boot/screen'
require_relative 'boot/getpocket_api'
