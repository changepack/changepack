# typed: false
# frozen_string_literal: true

module T
  Update = T.type_alias { ::Update }
  Updates = T.type_alias { ::Update::RelationType }
end

class Update < ApplicationRecord
  TYPES = %w[commit issue].freeze
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

  key :upd

  attribute :name, :string
  attribute :type, :string
  attribute :email, :string

  belongs_to :account
  belongs_to :source
  belongs_to :post, optional: true
  belongs_to :changelog, optional: true
  belongs_to :commit, optional: true
  belongs_to :issue, optional: true

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :email, presence: true
  validates :commit_id, uniqueness: { scope: :account_id }, if: :commit_id?
  validates :issue_id, uniqueness: { scope: :account_id }, if: :issue_id?

  inquirer :type

  scope :options, ->(pt) { where(post: [pt, nil]).order(OPTIONS.call(pt)) },
        sig: T.proc.params(pt: Post)
end
