# typed: false
# frozen_string_literal: true

class Update
  module Options
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    OPTIONS = T.let(
      lambda { |pt|
        Arel.sql(
          <<-SQL.squish
            CASE
              WHEN updates.post_id = '#{pt.id}' THEN 0
              ELSE 1
            END,
            updates.created_at DESC
          SQL
        )
      },
      T.proc.params(pt: Post).returns(String)
    )

    abstract!

    included do
      scope :options, ->(pt) { where(post: [pt, nil]).order(OPTIONS.call(pt)) },
            sig: T.proc.params(pt: Post)
    end
  end
end
