# frozen_string_literal: true

# TODO: remove, not used
Getpocket::Reviewer::Application.boot(:persistence) do |connector|
  init do 
    connector.register(:storage, Getpocket::Persistence::Storage)
  end

  start do
    # loader to load
  end
end
