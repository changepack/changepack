# typed: false
# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  renders_many :link_tos, 'LinkToComponent'

  class LinkToComponent < ApplicationComponent
    def initialize(title, url, active: false)
      @title = title
      @url = url
      @active = active

      super
    end

    def call
      link_to @title, @url, class: @active ? 'tab-active' : 'tab'
    end
  end
end
