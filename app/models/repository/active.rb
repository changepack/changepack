# frozen_string_literal: true

class Repository
  module Active
    extend ActiveSupport::Concern

    ACTIVITY = <<-SQL.squish
      CASE WHEN status = 'active' THEN 0 ELSE 1 END, created_at DESC
    SQL

    included do
      scope :active, -> { kept.where(status: :active) }
      scope :activity, -> { order(Arel.sql(ACTIVITY)) }
    end
  end
end
