# typed: false
# frozen_string_literal: true

class Hook < ApplicationRecord
  Request = StoreModel.one_of do |json|
    case json[:provider]
    when 'slack'
      Slack::Request
    else
      Unknown
    end
  end

  key :hook

  PROVIDERS = %w[slack].freeze
  DIRECTIONS = %w[outgoing incoming].freeze

  attribute :provider, :string
  attribute :direction, :string
  attribute :request, Request.to_type, default: -> { {} }

  belongs_to :account

  validates :request, presence: true, store_model: true
  validates :provider, presence: true, inclusion: { in: PROVIDERS }
  validates :direction, presence: true, inclusion: { in: DIRECTIONS }

  scope :slack, -> { where(provider: :slack) }
  scope :outgoing, -> { where(direction: :outgoing) }
  scope :incoming, -> { where(direction: :incoming) }

  inquirer :provider
  inquirer :direction
end
