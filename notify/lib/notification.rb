# typed: false
# frozen_string_literal: true

class Notification < ApplicationRecord
  key :ntf

  CHANNELS = %w[email web].freeze

  attribute :type, :string
  attribute :channels, :string, array: true, default: [CHANNELS]

  belongs_to :account

  has_many :deliveries
  has_many :users, through: :deliveries

  validates :type, presence: true
  validates :channels, presence: true, inclusion: { in: CHANNELS }

  inquirer :type
end
