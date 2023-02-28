# frozen_string_literal: true

class Repository < ApplicationRecord
  class Outdated < Event
    attribute :repository, Types::String
  end

  class Authorized < Event
    attribute :user, Types::String
  end

  include Git
  include Active
  include Status

  key :rep

  attribute :name, :string
  attribute :branch, :string
  attribute :pulled, :datetime
  attribute :status, :string, default: :inactive
  attribute :discarded, :datetime

  belongs_to :account
  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true

  normalize :name
  normalize :branch
  inquirer :status
end
