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

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited, presence: true
  validates :author, presence: true, store_model: true
  validates :provider, presence: true, inclusion: { in: Provider.types }
  validates :provider_id, presence: true

  inquirer :provider

  scope :github, -> { where(provider: :github) }
end
