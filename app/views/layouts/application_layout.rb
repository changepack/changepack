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
      navigation = NavigationComponent.new do |nav|
        nav.link_to 'Home', root_path, active: home?, if: user?
        nav.link_to 'Repositories', repositories_path, active: repositories?, if: user?
        nav.link_to 'Settings', edit_user_registration_path, active: account?, if: user?
      end

      render navigation
    end
  end

  def content
    main class: 'lg:container mx-auto my-8 md:my-28 px-5' do
      helpers.flash.each do |type, message|
        render FlashComponent.new(type:) { text message }
      end

      yield
    end
  end

  def home?
    helpers.current_controller.in?(%i[accounts changelogs])
  end

  def repositories?
    helpers.current_controller.in?(%i[repositories])
  end

  def account?
    helpers.current_controller.in?(%i[users/registrations])
  end

  def user?
    helpers.user_signed_in?
  end
end
