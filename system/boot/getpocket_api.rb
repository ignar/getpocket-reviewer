# typed: false
# frozen_string_literal: true

Application.boot(:getpocket_api) do |api|
  init do
    require 'getpocket/operations/fetcher'
    require 'getpocket/article'
    require 'getpocket/local_storage'
    require 'getpocket/client_configuration'
    require 'getpocket/request_token'
    require 'getpocket/access_token'
  end

  start do
    configuration = Getpocket::ClientConfiguration.new(
      consumer_key: '90239-d5cc68bdb01dc9ea77d3bef0',
      redirect_url: 'ruby-cli:authorizationFinished'
    )
    api.register('configuration.client_configuration', configuration)
    api.register('getpocket.operations.fetcher', Getpocket::Operations::Fetcher)
    api.register('getpocket.article', Getpocket::Article)
    api.register('getpocket.local_storage', Getpocket::LocalStorage)
    api.register('getpocket.request_token', Getpocket::RequestToken)
    api.register('getpocket.access_token', Getpocket::AccessToken)
  end
end
