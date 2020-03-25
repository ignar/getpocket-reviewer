# frozen_string_literal: true

require 'getpocket/reviewer/version'
require 'faraday'
require 'json'
require 'getpocket/reviewer/application'

module Getpocket
  module Reviewer
    class Error < StandardError; end
  end
end
