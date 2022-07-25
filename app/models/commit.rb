# frozen_string_literal: true

class Commit < ApplicationRecord
  include Provider

  key :com

  attribute :message, :text
  attribute :url, :string
  attribute :commited, :datetime
  attribute :author, Commit::Author.to_type, default: -> { {} }
  attribute :discarded, :datetime

  belongs_to :account
  belongs_to :repository
  belongs_to :changelog, optional: true

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited, presence: true
  validates :author, presence: true, store_model: true

  normalize :message

  inquirer :provider

  scope :github, -> { where("providers -> 'github' IS NOT NULL") }

  scope :review, lambda { |changelog|
    if changelog.new_record?
      self
    else
      where(changelog:).or(
        where(account: changelog.account)
      )
    end
  }

  scope :commited, lambda { |changelog|
    if changelog.new_record?
      order(commited: :desc)
    else
      order(
        Arel.sql("CASE WHEN changelog_id = '#{changelog.id}' THEN 0 ELSE 1 END, commited DESC")
      )
    end
  }
end
