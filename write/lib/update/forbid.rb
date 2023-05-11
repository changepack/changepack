# typed: false
# frozen_string_literal: true

class Update
  module Forbid
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      validate :valid_tags, on: :create
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def valid_tags
      forbidden = source.try(:forbiddens).try(:map, &:content) || []

      return if forbidden.none? { |regexp| tags.any? { |tag| tag =~ Regexp.new(regexp) } }

      errors.add(:tags, 'match a forbidden keyword')
    end
  end
end
