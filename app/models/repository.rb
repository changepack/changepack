# frozen_string_literal: true

class Repository < ApplicationRecord
  include Status

  key :rep

  attribute :name, :string
  attribute :branch, :string
  attribute :status, :string, default: :inactive
  attribute :provider, :string
  attribute :provider_id, :string

  belongs_to :account
  belongs_to :user

  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :branch, presence: true
  validates :status, presence: true
  validates :provider, presence: true, inclusion: { in: %w[github] }
  validates :provider_id, presence: true

  normalize :name
  normalize :branch

  inquirer :status
  inquirer :provider
end
