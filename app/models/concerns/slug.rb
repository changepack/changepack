# typed: false
# frozen_string_literal: true

module Slug
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  abstract!

  included do
    extend FriendlyId

    friendly_id :slug_candidates
  end

  sig { overridable.returns String }
  def set_slug_pretty_id
    set_pretty_id.gsub("#{self.class.id_prefix}#{self.class.id_separator}", '')
  end
end
