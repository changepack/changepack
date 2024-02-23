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
      errors.add(:tags, 'rejected by a filter') if rejected_by_filter?
    end

    sig { overridable.returns T.nilable(ActiveModel::Error) }
    def must_pass_selectable_filters
      errors.add(:tags, 'must match a filter') unless blank_or_selected_by_filter?
    end

    sig { returns(T::Boolean) }
    def rejected_by_filter?
      source&.filters&.select(&:reject?)&.any? { |filter| (filter & tags).any? }
    end

    sig { returns(T::Boolean) }
    def blank_or_selected_by_filter?
      filters = Array(source&.filters&.select(&:select?))
      filters.none? || filters.any? { |filter| (filter & tags).any? }
    end
  end
end
