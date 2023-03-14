# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  include Phlex::DeferredRender

  Brand = Struct.new(:name, :website, :picture) do
    def merge(account)
      dup.tap do |brand|
        brand.name = account.name if account.name.present?
        brand.website = account.website if account.website.present?
        brand.picture = account.picture if account.picture.present?
      end
    end
  end

  attr_writer :brand

  def template
    wrapper do
      logotype
      menu
    end
  end

  def wrapper(&)
    nav class: 'bg-white drop-shadow-sm md:drop-shadow-none overflow-x-auto' do
      div class: 'w-full mx-auto px-3 md:px-8' do
        div class: 'flex items-center justify-between h-16' do
          div class: 'flex items-center', &
        end
      end
    end
  end

  def logotype
    a class: 'flex-shrink-0', href: changepack.website do
      img src: helpers.image_path(changepack.picture), **classes('inline h-12 w-12', brand?: 'mr-2')
      span class: 'text-gray-800.hover:text-gray-800 py-2 text-sm font-bold' do
        text changepack.name
      end
    end
  end

  def menu
    div class: 'md:block' do
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

  def brand?
    changepack.picture != default_brand.picture
  end

  class Anchor < ApplicationComponent
    param :url, Types::String
    param :title, Types::String

    attribute :if, Types::Bool, default: -> { true }
    attribute :active, Types::Bool, default: -> { false }

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
