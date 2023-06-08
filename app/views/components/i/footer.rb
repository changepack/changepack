# typed: false
# frozen_string_literal: true

module I
  class Footer < ApplicationComponent
    class Brand < T::Struct
      attribute :name, T.nilable(String)
      attribute :website, T.nilable(String)
      attribute :picture, T.nilable(String)
    end

    def template
      wrapper do
        top
        hr
        bottom
      end
    end

    def wrapper(&)
      footer(class: 'bg-gray-100') { div(class: 'lg:container mx-auto p-5 py-6 lg:py-16', &) }
    end

    def top
      div(class: 'md:flex md:justify-between') do
        logotype
        menu
      end
    end

    def hr
      super(class: 'my-6 border-gray-200 sm:mx-auto lg:my-12')
    end

    def bottom
      div(class: 'sm:flex sm:items-center sm:justify-between') do
        powered_by
        accounts
      end
    end

    def logotype
      div(class: 'mb-6 md:mb-0') { render I::Logotype.new(brand:) }
    end

    def menu # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      menu_wrapper do
        if company?
          div(class: 'text-sm') do
            h2(class: 'mb-3 font-medium') { 'Company' }
            ul(class: 'dimmed') do
              li(class: 'mb-3') do
                a(href: helpers.content_for(:account_website)) do
                  helpers.content_for(:account_name)
                end
              end
            end
          end
        end
        div(class: 'text-sm') do
          h2(class: 'mb-3 font-medium') { ENV.fetch('APP_NAME') }
          ul(class: 'dimmed') do
            li(class: 'mb-3') { a(href: ENV.fetch('APP_SOURCE_CODE')) { 'GitHub' } }
          end
        end
      end
    end

    # Can't use `classes` in `#menu` because Tailwind doesn't detect
    # the conditional classes
    def menu_wrapper(&)
      if company?
        div(class: 'grid gap-8 sm:gap-24 grid-cols-2 sm:grid-cols-2', &)
      else
        div(&)
      end
    end

    def powered_by
      span(
        class: 'text-sm dimmed sm:text-center'
      ) do
        a(href: root_url) do
          "Powered by #{ENV.fetch('APP_NAME')}"
        end
      end
    end

    def accounts
      div(class: 'flex mt-4 space-x-6 sm:justify-center sm:mt-0') do
        a(
          href: ENV.fetch('APP_SOURCE_CODE'),
          class: 'dimmed hover:text-gray-900'
        ) do
          github_icon
          span(class: 'sr-only') { 'GitHub account' }
        end
      end
    end

    def github_icon
      svg(class: 'w-5 h-5', fill: 'currentColor', viewbox: '0 0 24 24', aria_hidden: 'true') do |s|
        s.path(
          fill_rule: 'evenodd',
          d: 'M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z', # rubocop:disable Layout/LineLength
          clip_rule: 'evenodd'
        )
      end
    end

    def company?
      helpers.content_for(:account_website).present? && helpers.content_for(:account_name).present?
    end

    def brand
      @brand ||= Brand.new(
        name: helpers.content_for(:account_name),
        website: helpers.content_for(:account_website),
        picture: helpers.content_for(:account_picture)
      )
    end
  end
end
