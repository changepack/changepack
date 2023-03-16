# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  include Phlex::DeferredRender

  attribute :brand, Types::Instance(Struct).optional

  def template
    wrapper do
      logotype
      menu
    end
  end

  def wrapper(&)
    nav class: 'bg-white drop-shadow-sm md:drop-shadow-none overflow-x-auto' do
      div class: 'w-full mx-auto px-5' do
        div class: 'flex items-center justify-between h-16' do
          div class: 'flex items-center w-full', &
        end
      end
    end
  end

  def logotype
    a class: 'flex-shrink-0', href: changepack.website do
      img src: helpers.image_path(changepack.picture), class: 'inline h-7 w-7 rounded-full mr-2'
      span class: 'hover:text-gray-800 py-2 text-sm font-bold' do
        text changepack.name
      end
    end
  end

  def menu
    div class: 'md:block w-full' do
      div class: 'ml-8 flex items-baseline space-x-4' do
        pages.each { |anchor| render anchor }
      end
    end
  end

  def link_to(...)
    pages << Anchor.new(...)
  end

  def pages
    @pages ||= []
  end

  def changepack
    @changepack ||= default_brand.merge(@brand)
  end

  def default_brand
    @default_brand ||= Brand.new('Changepack', root_path, 'logo.png')
  end

  class Anchor < ApplicationComponent
    param :url, Types::String
    param :title, Types::String

    attribute :if, Types::Bool, default: -> { true }
    attribute :active, Types::Bool, default: -> { false }
    attribute :position, Types::Coercible::Symbol, default: -> { :left }

    def template
      unsafe_raw helpers.link_to url, title, **classes(activity, right?: 'ml-auto') if display?
    end

    def activity
      active ? 'tab-active' : 'tab'
    end

    def display?
      @if
    end

    def right?
      @position == :right
    end
  end

  Brand = Struct.new(:name, :website, :picture) do
    def merge(other)
      Brand.new(*to_h.merge(other.to_h.compact).values)
    end
  end
end
