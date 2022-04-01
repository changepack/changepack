# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  renders_many :link_tos, 'LinkToComponent'

  class LinkToComponent < ViewComponent::Base
    def initialize(title, url)
      @title = title
      @url = url
    end

    def call
      link_to @title, @url, class: 'text-gray-500 hover:text-gray-800 px-3 py-2 text-sm font-medium'
    end
  end
end
