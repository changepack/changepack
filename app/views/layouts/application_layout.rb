# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  def template(&)
    doctype
    html do
      head_tag
      body do
        navigation
        content(&)
      end
    end
  end

  def head_tag
    head do
      title { 'Changepack' }

      meta name: 'viewport', content: 'width=device-width,initial-scale=1'
      meta name: 'turbo-cache-control', content: 'no-cache'

      csp_meta_tag
      csrf_meta_tags

      stylesheet_link_tag 'application', data_turbo_track: 'reload'
      stylesheet_link_tag 'tailwind', data_turbo_track: 'reload'

      javascript_importmap_tags
    end
  end

  def navigation
    header class: 'w-full mx-auto' do
      unsafe_raw navigation_component
    end
  end

  def navigation_component
    helpers.component :navigation do |nav|
      if helpers.user_signed_in?
        nav.link_to 'Home', root_path, active: helpers.current_controller.in?(%i[accounts changelogs])
        nav.link_to 'Repositories', repositories_path, active: helpers.current_controller.in?(%i[repositories])
      end
    end
  end

  def content
    main class: 'lg:container mx-auto my-8 md:my-28 px-5' do
      flash

      yield
    end
  end

  def flash
    helpers.flash.select { |_, message| message.present? }.each do |type, message|
      unsafe_raw helpers.component(:flash, type:) do
        text message
      end
    end
  end
end
