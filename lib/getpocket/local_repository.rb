# typed: ignore
# frozen_string_literal: true

module Getpocket
  class LocalRepository
    include Import['getpocket.local_storage']

    def save(article)
      LocalStorage.save(article)
    end

    def retrieve(per_page:, first_element: nil)
      # TODO: missing abstraction
      index = first_element.nil? ? 0 : local_storage.all.index(first_element)
      local_storage.all.slice(index..(per_page + index))
    end

    # TODO: inconsistent naming (element or entry)
    def previous(element)
      index = local_storage.all.index(element)

      return element if index == 0

      local_storage.all[index - 1]
    end
  end
end
