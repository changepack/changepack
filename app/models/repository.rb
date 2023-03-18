# typed: false
# frozen_string_literal: true

class Repository < ApplicationRecord
  include ActiveModel::T

  include Events
  include Git

  include Active
  include Status

  key :rep

  attribute :name, :string
  attribute :branch, :string
  attribute :pulled, :datetime
  attribute :status, :string, default: :inactive

  belongs_to :account
  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true

  normalize :name
  normalize :branch
  inquirer :status
end
