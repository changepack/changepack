# typed: false
# frozen_string_literal: true

class Update
  module Filter
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      validate :must_pass_rejectable_filters, on: :create
      validate :must_pass_selectable_filters, on: :create
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def must_pass_rejectable_filters
      return if source.blank?
      return if source.filters
                      .select(&:reject?)
                      .none? { |filter| (filter & tags).any? }

      errors.add(:tags, 'rejected by a filter')
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def must_pass_selectable_filters
      return if source.blank?

      filters = source.filters.select(&:select?)
      return if filters.none?
      return if filters.any? { |filter| (filter & tags).any? }

      errors.add(:tags, 'must match a filter')
    end
  end
end
