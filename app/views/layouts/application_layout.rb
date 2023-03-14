# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  Brand = Struct.new(:name, :website, :picture)

  attr_reader :brand

  def template(&)
    white_label

    doctype
    html do
      head_tag(&)
      body do
        navigation(&)
        content(&)
      end
    end
  end

  def head_tag(&)
    head do
      title { helpers.content_for?(:title) ? yield(:title) : 'Changepack' }
      meta_tags(&)

      stylesheet_link_tag 'application', data_turbo_track: 'reload'
      stylesheet_link_tag 'tailwind', data_turbo_track: 'reload'

      javascript_importmap_tags
    end
  end

  def meta_tags
    meta name: 'viewport', content: 'width=device-width,initial-scale=1'
    meta name: 'turbo-cache-control', content: 'no-cache'

    yield(:description) if helpers.content_for?(:description)

    csp_meta_tag
    csrf_meta_tags
  end

  def navigation(&) # rubocop:disable Metrics/AbcSize
    header class: 'w-full mx-auto' do
      navigation = NavigationComponent.new do |nav|
        nav.brand = brand

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

  def white_label
    @brand = Brand.new(
      helpers.content_for(:account_name),
      helpers.content_for(:account_website),
      helpers.content_for(:account_picture)
    )
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
