# typed: false
# frozen_string_literal: true

module T
  Issue = T.type_alias { ::Issue }
  Issues = T.type_alias { ::Issue::RelationType }
end

class Issue < ApplicationRecord
  include Provided

  key :is

  attribute :title, :string
  attribute :description, :string
  attribute :assignee, Issue::Assignee.to_type, default: -> { {} }
  attribute :labels, :string, array: true, default: []
  attribute :priority, :decimal
  attribute :done, :boolean
  attribute :branch, :string
  attribute :identifier, :string

  belongs_to :account
  belongs_to :team

  validates :title, presence: true
  validates :assignee, presence: true, store_model: true
  normalize :title
  normalize :description
  normalize :branch
  normalize :identifier

  provider :linear
end
