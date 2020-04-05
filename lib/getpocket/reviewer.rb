# frozen_string_literal: true

require 'getpocket/reviewer/version'
require 'faraday'
require 'json'
require 'dry-struct'
require 'dry-types'
require 'dry-transaction'
require "dry/transaction/operation"

require 'getpocket/reviewer/application'
require 'getpocket/reviewer/connector'
require 'getpocket/reviewer/screen'
require 'getpocket/types'
require 'getpocket/client_configuration'
require 'getpocket/request_token'
require 'getpocket/access_token'

module Getpocket
  module Reviewer
    class Error < StandardError; end
  end
end
