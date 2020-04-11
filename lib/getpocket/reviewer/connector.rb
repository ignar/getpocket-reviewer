# frozen_string_literal: true

Getpocket::Reviewer::Application.boot(:connector) do |connector|
  init do
    require 'getpocket/operations/fetcher'
    require 'getpocket/article'
    require 'getpocket/local_storage'
  end

  start do
    configuration = Getpocket::Reviewer::ClientConfiguration.new(
      consumer_key: '90239-d5cc68bdb01dc9ea77d3bef0',
      redirect_url: 'ruby-cli:authorizationFinished'
    )
    connector.register('configuration.client_configuration', configuration)
    connector.register('getpocket.operations.fetcher', Getpocket::Operations::Fetcher)
    connector.register('getpocket.article', Getpocket::Article)
    connector.register('getpocket.local_storage', Getpocket::LocalStorage)
  end
end
