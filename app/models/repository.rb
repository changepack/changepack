# frozen_string_literal: true

class Repository < ApplicationRecord
  include Git
  include Events

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
