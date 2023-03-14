# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  include Phlex::DeferredRender

  Account = Struct.new(:name, :website, :picture)

  attr_writer :account

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
    a class: 'flex-shrink-0', href: root do
      img src: helpers.image_path(picture), **classes('inline h-12 w-12', account_picture?: 'mr-2')
      span class: 'text-gray-800.hover:text-gray-800 py-2 text-sm font-bold' do
        text title
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

  def root
    account.website.presence || root_path
  end

  def picture
    account.picture.presence || 'logo.png'
  end

  def title
    account.name.presence || 'Changepack'
  end

  def account
    @account ||= Account.new
  end

  def account_picture?
    account.picture.present?
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
