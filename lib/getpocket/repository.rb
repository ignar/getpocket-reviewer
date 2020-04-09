# frozen_string_literal: true
module Getpocket
  class Repository
    def add; end

    def modify; end

    def retrieve(since: nil)
      fetcher = Operations::Fetcher.new
      fetcher.call(since: since)
    end
  end
end
