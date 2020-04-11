# frozen_string_literal: true
module Getpocket
  class Repository
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def add; end

    def modify; end

    def retrieve(since: nil, per_page:)
      fetcher = Operations::Fetcher.new(config)
      fetcher.call(since: since, per_page: per_page)
    end
  end
end
