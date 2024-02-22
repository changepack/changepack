# typed: false
# frozen_string_literal: true

class Update
  module Filter
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      validate :valid_tags, on: :create
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def valid_tags
      filter = source.try(:filters).try(:map, &:content) || []

      return if filter.none? { |regexp| tags.any? { |tag| tag =~ Regexp.new(regexp) } }

      errors.add(:tags, 'match a filter keyword')
    end
  end
end
