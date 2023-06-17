# typed: false
# frozen_string_literal: true

class FormLayout < ApplicationView
  include Phlex::Rails::Layout

  def template(&)
    doctype
    html do
      head_tag
      body do
        top(&)
        page(&)
      end
    end
  end

  def head_tag
    head do
      title { ENV.fetch('APP_NAME') }
      meta_tags

      stylesheet_link_tag 'application', data_turbo_track: 'reload'
      stylesheet_link_tag 'tailwind', data_turbo_track: 'reload'

      javascript_importmap_tags
    end
  end

  def meta_tags
    meta name: 'viewport', content: 'width=device-width,initial-scale=1'
    meta name: 'turbo-cache-control', content: 'no-cache'

    if helpers.content_for?(:description)
      meta name: 'description', content: helpers.content_for(:description)
      meta property: 'og:description', content: helpers.content_for(:description)
    end

    meta property: 'og:title', content: ENV.fetch('APP_NAME')

    csp_meta_tag
    csrf_meta_tags
  end

  def top(&)
    return unless top?

    top_container do
      div do
        show_previous_page
        page_name
      end
      actions(&)
    end
  end

  def page(&)
    div class: 'container mx-auto my-16 px-80', &
  end

  def top_container(&)
    div class: 'w-full px-2 bg-white shadow-sm' do
      div class: 'relative overflow-hidden' do
        div class: 'flex-row items-center justify-between p-4 space-y-3 sm:flex sm:space-y-0 sm:space-x-4', &
      end
    end
  end

  def show_previous_page
    return if helpers.content_for?(:previous_page).blank?

    a class: 'font-bold inline-block mr-6 text-xl leading-none', href: helpers.content_for(:previous_page) do
      '×'
    end
  end

  def page_name
    return if helpers.content_for?(:page_name).blank?

    span class: 'dimmed' do
      helpers.content_for(:page_name)
    end
  end

  def actions(&)
    return if helpers.content_for?(:actions).blank?

    yield :actions
  end

  def top?
    helpers.content_for?(:page_name) || helpers.content_for?(:previous_page) || helpers.content_for?(:actions)
  end
end
