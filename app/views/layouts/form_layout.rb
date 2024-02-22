# typed: false
# frozen_string_literal: true

class FormLayout < ApplicationView
  include Phlex::Rails::Layout

  def template(&block)
    doctype
    html do
      head_tag
      body(&block)
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
    meta property: 'og:title', content: ENV.fetch('APP_NAME')

    csp_meta_tag
    csrf_meta_tags
  end
end
