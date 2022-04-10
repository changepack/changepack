# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  option :changelogs, type: Types::Relation | Types::Array.of(Types::Instance(Changelog))
  option :account, model: Account

  def before_render
    @pagy, @collection = changelogs.is_a?(Array) ? pagy_array(changelogs) : pagy(changelogs)
  end
end
