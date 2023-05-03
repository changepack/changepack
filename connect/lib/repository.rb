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
  belongs_to :access_token, optional: true
  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true
  normalize :name
  normalize :branch

  inquirer :status

  after_commit :created!, on: :create

  private

  sig { returns String }
  def created!
    pub Created.new(id:, account_id:, name:, status: status.to_s)
  end

  sig { returns String }
  def updated!
    pub Updated.new(id:, account_id:, name:, status: status.to_s)
  end

  sig { returns String }
  def destroyed!
    pub Destroyed.new(id:)
  end
end
