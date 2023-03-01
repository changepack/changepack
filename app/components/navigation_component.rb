# frozen_string_literal: true

class NavigationComponent < LegacyApplicationComponent
  renders_many :link_tos, 'LinkToComponent'

  class LinkToComponent < LegacyApplicationComponent
    option :active, default: -> { false }
    param :title, Types::String
    param :url, Types::String

    def call
      link_to title, url, class: active ? 'tab-active' : 'tab'
    end
  end
end
