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

  def template(&)
    white_label

    doctype
    html do
      head_tag(&)
      body do
        navigation
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

  def navigation
    header class: 'lg:container mx-auto' do
      navigation = I::Navigation.new(brand:) do |nav|
        next if helpers.user_signed_out?

        nav.link_to 'Home', root_path, active: home?
        nav.link_to 'Repositories', repositories_path, active: repositories?
      end

      render navigation
    end
  end

  def content
    main class: 'lg:container mx-auto my-8 md:my-32 px-5' do
      helpers.flash.each do |type, message|
        render I::Flash.new(type:) { plain message }
      end

      yield
    end
  end

  def white_label
    @brand = Brand.new(
      name: helpers.content_for(:account_name),
      website: helpers.content_for(:account_website),
      picture: helpers.content_for(:account_picture)
    )
  end

  def home?
    helpers.current_controller.in?(%i[accounts posts])
  end

  def repositories?
    helpers.current_controller.in?(%i[repositories])
  end

  def settings
    helpers.user_signed_in?
  end
end
