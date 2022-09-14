# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  option :changelogs, Types::Relation | Types::Array.of(Types::Instance(Changelog))
  option :account, Types::Instance(Account)

  def before_render
    @pagy, @collection = changelogs.is_a?(Array) ? helpers.pagy_array(changelogs) : helpers.pagy(changelogs)
  end

  private

  attr_reader :pagy, :collection
end
