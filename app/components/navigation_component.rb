# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  renders_many :link_tos, 'LinkToComponent'

  class LinkToComponent < ViewComponent::Base
    def initialize(title, url, active: false)
      @title = title
      @url = url
      @active = active
    end

    def call
      link_to @title, @url, class: "button mini #{@active && 'primary'}"
    end
  end
end
