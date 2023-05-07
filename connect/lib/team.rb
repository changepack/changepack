# typed: false
# frozen_string_literal: true

module T
  Team = T.type_alias { ::Team }
  Teams = T.type_alias { ::Team::RelationType }
end

class Team < ApplicationRecord
  include Events

  include Resourcable
  include Provided
  include Status
  include Active

  key :tm

  attribute :name, :string
  attribute :schema, Schema.to_type, default: -> { {} }
  attribute :status, :string, default: :inactive

  belongs_to :account
  belongs_to :access_token, optional: true
  has_many :issues, dependent: :destroy

  validates :name, presence: true
  validates :schema, store_model: true
  validates :status, presence: true
  normalize :name

  provider :linear
end
