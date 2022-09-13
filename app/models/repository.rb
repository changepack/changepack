# frozen_string_literal: true

class Repository < ApplicationRecord
  include Status
  include Provider

  key :rep

  attribute :name, :string
  attribute :branch, :string
  attribute :pulled, :datetime
  attribute :status, :string, default: :inactive
  attribute :discarded, :datetime

  belongs_to :account
  belongs_to :user

  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true

  normalize :name
  normalize :branch

  inquirer :status

  provider :github

  scope :active, -> { kept.where(status: :active) }
  scope :activity, lambda {
    order(
      Arel.sql("CASE WHEN status = 'active' THEN 0 ELSE 1 END, created_at DESC")
    )
  }
end
