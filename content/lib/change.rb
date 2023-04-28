# typed: false
# frozen_string_literal: true

module T
  Change = T.type_alias { ::Change }
  Changes = T.type_alias { ::Change::RelationType }
end

class Change < ApplicationRecord
  TYPES = %w[commit].freeze
  OPTIONS = T.let(
    lambda { |pt|
      Arel.sql(
        <<-SQL.squish
          CASE
            WHEN commits.post_id = '#{pt.id}' THEN 0
            ELSE 1
          END,
          commits.commited_at DESC
        SQL
      )
    },
    T.proc.params(pt: Post).returns(String)
  )

  self.inheritance_column = false

  key :cha

  attribute :name, :string
  attribute :type, :string

  belongs_to :account
  belongs_to :commit
  belongs_to :post, optional: true

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :commit_id, uniqueness: { scope: :account_id }

  scope :options, ->(pt) { where(post: [pt, nil]).order(OPTIONS.call(pt)) },
        sig: T.proc.params(cl: Post)
end
