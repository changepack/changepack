# frozen_string_literal: true

class Commit < ApplicationRecord
  key :com

  attribute :message, :text
  attribute :url, :string
  attribute :commited, :datetime
  attribute :author, Commit::Author.to_type, default: {}
  attribute :provider, :string
  attribute :provider_id, :string

  belongs_to :account
  belongs_to :repository
  belongs_to :changelog, optional: true

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited, presence: true
  validates :author, presence: true, store_model: true
  validates :provider, presence: true, inclusion: { in: Provider.types }
  validates :provider_id, presence: true

  inquirer :provider

  scope :github, -> { where(provider: :github) }

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
