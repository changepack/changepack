# typed: false
# frozen_string_literal: true

module Active
  extend ActiveSupport::Concern
  extend T::Helpers

  abstract!

  ACTIVITY = <<-SQL.squish
    CASE WHEN status = 'active' THEN 0 ELSE 1 END, created_at DESC
  SQL

  included do
    scope :active, -> { kept.where(status: :active) }
    scope :activity, -> { order(Arel.sql(ACTIVITY)) }
  end
end
