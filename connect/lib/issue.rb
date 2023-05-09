# typed: false
# frozen_string_literal: true

module T
  Issue = T.type_alias { ::Issue }
  Issues = T.type_alias { ::Issue::RelationType }
end

class Issue < ApplicationRecord
  include Events

  include Resourcable
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
  attribute :issued_at, :datetime

  belongs_to :account
  belongs_to :team

  validates :title, presence: true
  validates :assignee, presence: true, store_model: true
  validates :issued_at, presence: true
  normalize :title
  normalize :description
  normalize :branch
  normalize :identifier

  provider :linear

  sig { returns T::Hash[Symbol, T.any(String, Hash)] }
  def self.to_shape
    {
      title: String,
      description: String,
      providers: { linear: String }
    }
  end
end
