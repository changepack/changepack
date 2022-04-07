# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  renders_many :link_tos, 'LinkToComponent'

  class LinkToComponent < ApplicationComponent
    param :title
    param :url
    option :active, default: -> { false }

    def call
      link_to title, url, class: active ? 'tab-active' : 'tab'
    end
  end
end
