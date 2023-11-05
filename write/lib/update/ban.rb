# typed: false
# frozen_string_literal: true

class Update
  module Ban
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      validate :valid_tags, on: :create
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def valid_tags
      banned = source.try(:banneds).try(:map, &:content) || []

      return if banned.none? { |regexp| tags.any? { |tag| tag =~ Regexp.new(regexp) } }

      errors.add(:tags, 'match a banned keyword')
    end
  end
end
