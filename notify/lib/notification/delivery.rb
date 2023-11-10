# typed: false
# frozen_string_literal: true

class Notification
  class Delivery < ApplicationRecord
    key :ntfd

    belongs_to :notification
    belongs_to :user

    attribute :queued_at, :datetime
    attribute :sent_at, :datetime
    attribute :channel, :string

    validates :channel, presence: true, inclusion: { in: Notification::CHANNELS }
    inquirer :channel

    scope :pending, -> { where(queued_at: nil, sent_at: nil) }
    scope :queued, -> { where.not(queued_at: nil).where(sent_at: nil) }
    scope :sent, -> { where.not(sent_at: nil) }
  end
end
