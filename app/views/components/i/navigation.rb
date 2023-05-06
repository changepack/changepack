# typed: false
# frozen_string_literal: true

module I
  class Navigation < ApplicationComponent
    class Logotype < ApplicationComponent
      class Brand < T::Struct
        attribute :name, String
        attribute :website, String
        attribute :picture, String

        def self.default(website)
          Brand.new(name: ENV.fetch('APP_NAME'), picture: 'logo.png', website:)
        end

        def merge(other)
          Brand.new(**serialize.merge(other.serialize.compact).deep_symbolize_keys)
        end
      end

      attribute :brand, T.nilable(T::Struct)

      def template
        a class: 'flex-shrink-0 flex items-center', href: changepack.website do
          img src: helpers.image_path(changepack.picture), class: 'inline h-7 w-7 rounded-full mr-2'
          span class: 'hover:text-gray-800 text-m font-semibold' do
            plain changepack.name
          end
        end
      end

      def changepack
        @changepack ||= Brand.default(root_url).merge(brand)
      end
    end

    class Menu < ApplicationComponent
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

      class Account < ApplicationComponent
        def template
          sm
          md
        end

        def sm
          a href: helpers.edit_user_registration_path, **classes('tab inline md:hidden', account?: 'tab-active') do
            plain 'Settings'
          end
        end

        def md
          a href: helpers.edit_user_registration_path, class: 'ml-auto hidden md:inline', title: 'Settings' do
            div class: 'flex items-center' do
              icon 'cog', **classes('text-gray-400 mr-2 p-2', account?: 'bg-orange-900 text-white rounded-full')
              render I::AccountPicture.new(account: helpers.current_account)
            end
          end
        end

        def account?
          helpers.current_controller.in?(%i[users/registrations])
        end
      end

      attribute :pages, T::Array[Anchor]

      def template
        div class: 'md:block w-full' do
          div class: 'ml-12 flex items-baseline space-x-4' do
            pages.each { |anchor| render anchor }

            render Account.new if helpers.user_signed_in?
          end
        end
      end
    end

    include Phlex::DeferredRender

    attribute :brand, T.nilable(T::Struct)

    def template
      wrapper do
        render Logotype.new(brand:)
        render Menu.new(pages:)
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

    def link_to(...)
      pages << Menu::Anchor.new(...)
    end

    def pages
      @pages ||= []
    end
  end
end
