# typed: false
# frozen_string_literal: true

module T
  Repository = T.type_alias { ::Repository }
  Repositories = T.type_alias { ::Repository::RelationType }
end

class Repository < ApplicationRecord
  include Events
  include Git

  include Active
  include Status

  key :rep

  attribute :name, :string
  attribute :branch, :string
  attribute :pulled_at, :datetime
  attribute :status, :string, default: :inactive

  belongs_to :account
  belongs_to :changelog
  has_many :commits, dependent: :destroy
  has_many :access_tokens, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true

  normalize :name
  normalize :branch
  inquirer :status
end
