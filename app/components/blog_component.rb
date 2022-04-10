# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  option :changelogs
  option :account

  def before_render
    @pagy, @collection = changelogs.is_a?(Array) ? pagy_array(changelogs) : pagy(changelogs)
  end
end
