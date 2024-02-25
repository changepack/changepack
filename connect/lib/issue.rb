# typed: false
# frozen_string_literal: true

class Issue < ApplicationRecord
  include Events
  include Pull

  include Resourcable

  key :is

  attribute :title, :string
  attribute :description, :string
  attribute :assignee, Issue::Assignee.to_type
  attribute :labels, :string, array: true, default: []
  attribute :priority, :decimal
  attribute :done, :boolean
  attribute :branch, :string
  attribute :identifier, :string
  attribute :issued_at, :datetime

  belongs_to :team
  belongs_to :account, default: -> { team&.account }

  validates :title, presence: true
  validates :assignee, store_model: true, allow_blank: true
  validates :issued_at, presence: true

  normalizes :title, with: ->(title) { title.squish }
  normalizes :description, with: ->(description) { description.squish }
  normalizes :branch, with: ->(branch) { branch.squish }
  normalizes :identifier, with: ->(identifier) { identifier.squish }
end
