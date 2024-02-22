# typed: false
# frozen_string_literal: true

class Update
  module Filter
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      validate :must_pass_filters, on: :create
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def must_pass_filters
      return if source.blank?
      return if source.filters
                      .select(&:reject?)
                      .map(&:content)
                      .none? { |regexp| tags.any? { |tag| tag =~ Regexp.new(regexp) } }

      errors.add(:tags, 'match a filter keyword')
    end
  end
end
