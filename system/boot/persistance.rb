# frozen_string_literal: true

Application.boot(:persistance) do
  init do
    require 'pstore'
  end

  start do
    register('getpocket.database', PStore.new('getpocket.pstore'))
  end
end
