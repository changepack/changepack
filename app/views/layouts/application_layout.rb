# typed: false
# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  class Brand < T::Struct
    attribute :name, T.nilable(String)
    attribute :website, T.nilable(String)
    attribute :picture, T.nilable(String)
  end

  attr_reader :brand

  def template(&block)
    white_label

    doctype
    html do
      head_tag(&block)
      body do
        page_container(&block)
      end
    end
  end

  def head_tag(&block)
    head do
      title { title_or_app_name }
      meta_tags(&block)

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

    meta property: 'og:title', content: title_or_app_name

    csp_meta_tag
    csrf_meta_tags
  end

  def page_container(&block)
    div class: 'flex flex-col min-h-screen' do
      div class: 'flex-grow' do
        navigation
        content(&block)
      end
      div class: 'flex-none' do
        footer
      end
    end
  end

  def navigation
    header class: 'lg:container mx-auto' do
      navigation = I::Navigation.new(brand:) do |nav|
        next if skip_navigation?

        nav.link_to 'Home', root_path, active: home?
        nav.link_to 'Compose', new_post_path, active: compose?
        nav.link_to 'Connections', sources_path, active: sources?
      end

      render navigation
    end
  end

  def content
    main class: 'lg:container mx-auto my-8 md:my-32 px-5' do
      helpers.flash.each do |type, message|
        render I::Flash.new(type:, message:)
      end

      yield
    end
  end

  def footer
    return if skip_footer?

    render I::Footer.new
  end

  def white_label
    @brand = Brand.new(
      name: helpers.content_for(:account_name),
      website: helpers.content_for(:account_website),
      picture: helpers.content_for(:account_picture)
    )
  end

  def skip_navigation?
    helpers.user_signed_out?
  end

  def skip_footer?
    !skip_navigation?
  end

  def home?
    helpers.current_controller.in?(%i[posts]) && !helpers.current_action.in?(%i[new edit])
  end

  def compose?
    helpers.current_controller.in?(%i[posts]) && helpers.current_action.in?(%i[new edit])
  end

  def sources?
    helpers.current_controller.in? %i[sources]
  end

  def settings
    helpers.user_signed_in?
  end

  def title_or_app_name
    helpers.content_for?(:title) ? helpers.content_for(:title) : ENV.fetch('APP_NAME')
  end
end
