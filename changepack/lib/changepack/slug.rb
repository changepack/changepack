# frozen_string_literal: true

module Changepack
  module Slug
    extend ActiveSupport::Concern

    included do
      extend FriendlyId

      friendly_id :slug_candidates
    end

    def set_slug_pretty_id
      set_pretty_id.gsub("#{self.class.id_prefix}#{self.class.id_separator}", '')
    end
  end
end
