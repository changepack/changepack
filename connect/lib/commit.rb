# typed: false
# frozen_string_literal: true

class Commit < ApplicationRecord
  include Events
  include Pull

  include Resourcable

  key :com

  attribute :url, :string
  attribute :message, :text
  attribute :commited_at, :datetime
  attribute :author, Author.to_type, default: -> { {} }

  belongs_to :account
  belongs_to :repository

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited_at, presence: true
  validates :author, presence: true, store_model: true
  validates :providers, presence: true, uniqueness: { scope: :repository_id }

  normalizes :message, with: ->(message) { message.squish }

  before_validation do
    self.account ||= repository.account if repository_id.present?
  end
end
