# typed: false
# frozen_string_literal: true

module T
  Issues = T.type_alias { ::Issue::RelationType }
end

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

  belongs_to :account
  belongs_to :team

  validates :title, presence: true
  validates :assignee, store_model: true, allow_blank: true
  validates :issued_at, presence: true
  normalize :title
  normalize :description
  normalize :branch
  normalize :identifier

  before_validation do
    self.account ||= team.try(:account)
  end
end
