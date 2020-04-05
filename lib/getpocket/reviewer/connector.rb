# frozen_string_literal: true

Getpocket::Reviewer::Application.boot(:connector) do |connector|
  start do
    configuration = Getpocket::Reviewer::ClientConfiguration.new(
      consumer_key: '90239-d5cc68bdb01dc9ea77d3bef0',
      redirect_url: 'ruby-cli:authorizationFinished'
    )
    connector.register('configuration.client_configuration', configuration)
  end
end
