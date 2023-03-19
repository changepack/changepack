# typed: false
# frozen_string_literal: true

class NavigationComponent < ApplicationComponent
  include Phlex::DeferredRender

  attribute :brand, T::Struct.nilable

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
    a class: 'flex-shrink-0 flex items-center', href: changepack.website do
      img src: helpers.image_path(changepack.picture), class: 'inline h-7 w-7 rounded-full mr-2'
      span class: 'hover:text-gray-800 text-m font-semibold' do
        text changepack.name
      end
    end
  end

  def menu
    div class: 'md:block w-full' do
      div class: 'ml-12 flex items-baseline space-x-4' do
        pages.each { |anchor| render anchor }

        edit_user_registration
      end
    end
  end

  def edit_user_registration
    return if helpers.user_signed_out?

    edit_user_registration_sm
    edit_user_registration_md
  end

  def edit_user_registration_sm
    a href: helpers.edit_user_registration_path, **classes('tab inline md:hidden', account?: 'tab-active') do
      text 'Settings'
    end
  end

  def edit_user_registration_md
    a href: helpers.edit_user_registration_path, class: 'ml-auto hidden md:inline', title: 'Settings' do
      div class: 'flex items-center' do
        icon 'cog', **classes('text-gray-400 mr-2 p-2', account?: 'bg-orange-900 text-white rounded-full')
        render AccountPictureComponent.new(account: helpers.current_account)
      end
    end
  end

  def account?
    helpers.current_controller.in?(%i[users/registrations])
  end

  def link_to(...)
    pages << Anchor.new(...)
  end

  def pages
    @pages ||= []
  end

  def changepack
    @changepack ||= default_brand.merge(brand)
  end

  def default_brand
    @default_brand ||= Brand.new(name: 'Changepack', website: root_path, picture: 'logo.png')
  end

  class Brand < T::Struct
    attribute :name, String
    attribute :website, String
    attribute :picture, String

    def merge(other)
      Brand.new(**serialize.merge(other.serialize.compact).deep_symbolize_keys)
    end
  end

  class Anchor < ApplicationComponent
    param :name, default: -> {}
    param :options, default: -> {}
    param :html_options, default: -> { {} }

    attribute :if, T::Boolean, as: :show, default: -> { true }
    attribute :active, T::Boolean, default: -> { false }

    def template(&)
      return if hide?

      unsafe_raw helpers.link_to name, options, html_options.merge(classes(activity))
    end

    def activity
      active ? 'tab-active' : 'tab'
    end

    def hide?
      show.blank?
    end
  end
end
