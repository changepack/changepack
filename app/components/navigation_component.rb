# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  renders_many :link_tos, 'LinkToComponent'

  class LinkToComponent < ApplicationComponent
    option :active, default: -> { false }
    param :title, type: Types::String
    param :url, type: Types::String

    def call
      link_to title, url, class: active ? 'tab-active' : 'tab'
    end
  end
end
