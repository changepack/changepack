# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  include Phlex::DeferredRender

  def template
    wrapper do
      logotype
      pages
    end
  end

  def wrapper(&)
    nav class: 'bg-white drop-shadow-sm md:drop-shadow-none' do
      div class: 'w-full mx-auto px-3 md:px-8' do
        div class: 'flex items-center justify-between h-16' do
          div class: 'flex items-center', &
        end
      end
    end
  end

  def logotype
    a class: 'flex-shrink-0', href: root_path do
      img class: 'inline h-12 w-12', src: helpers.image_path('logo.png')
      span class: 'text-gray-800.hover:text-gray-800.py-2.text-sm.font-bold' do
        span class: 'text-gray-800 hover:text-gray-800 py-2 text-sm font-bold' do
          text 'Changepack'
        end
      end
    end
  end

  def pages
    div class: 'md:block' do
      div class: 'ml-8 flex items-baseline space-x-4' do
        @pages&.each { |anchor| render anchor }
      end
    end
  end

  def link_to(...)
    @pages ||= []
    @pages << Anchor.new(...)
  end

  class Anchor < ApplicationComponent
    param :url, Types::String
    param :title, Types::String

    option :active, default: -> { false }
    option :if, default: -> { true }

    def template
      unsafe_raw helpers.link_to url, title, class: activity if display?
    end

    def activity
      active ? 'tab-active' : 'tab'
    end

    def display?
      @if
    end
  end
end
