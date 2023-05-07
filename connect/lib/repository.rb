# typed: false
# frozen_string_literal: true

module T
  Repository = T.type_alias { ::Repository }
  Repositories = T.type_alias { ::Repository::RelationType }
end

class Repository < ApplicationRecord
  include Events
  include Git

  include Resourcable
  include Active
  include Status

  key :rep

  attribute :name, :string
  attribute :branch, :string
  attribute :pulled_at, :datetime
  attribute :status, :string, default: :inactive

  belongs_to :account
  belongs_to :access_token, optional: true
  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true
  validates :providers, presence: true, uniqueness: { scope: :account_id }
  normalize :name
  normalize :branch

  inquirer :status
end
