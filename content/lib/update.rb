# typed: false
# frozen_string_literal: true

module T
  Update = T.type_alias { ::Update }
  Updates = T.type_alias { ::Update::RelationType }
end

class Update < ApplicationRecord
  TYPES = %w[commit].freeze
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

  self.inheritance_column = false

  key :upd

  attribute :name, :string
  attribute :type, :string

  belongs_to :account
  belongs_to :source
  belongs_to :commit, optional: true
  belongs_to :post, optional: true

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :commit_id, uniqueness: { scope: :account_id }

  scope :options, ->(pt) { where(post: [pt, nil]).order(OPTIONS.call(pt)) },
        sig: T.proc.params(pt: Post)
end
