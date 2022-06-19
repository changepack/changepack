# frozen_string_literal: true

module Changepack
  module Slug
    extend ActiveSupport::Concern

    included do
      extend FriendlyId

      friendly_id :slug_candidates
    end
  end
end
