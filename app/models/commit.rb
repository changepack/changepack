# frozen_string_literal: true

class Commit < ApplicationRecord
  include Git

  OPTIONS = lambda { |cl|
    Arel.sql(
      %(
        CASE
          WHEN commits.changelog_id = '#{cl.id}' THEN 0
          ELSE 1
        END,
        commits.commited_at DESC
      ).strip
    )
  }

  key :com

  attribute :message, :text
  attribute :url, :string
  attribute :commited_at, :datetime
  attribute :author, Commit::Author.to_type, default: -> { {} }

  belongs_to :account
  belongs_to :repository
  belongs_to :changelog, optional: true

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited_at, presence: true
  validates :author, presence: true, store_model: true

  normalize :message

  scope :options, ->(cl) { where(changelog: [cl, nil]).order(OPTIONS.call(cl)) }
end
