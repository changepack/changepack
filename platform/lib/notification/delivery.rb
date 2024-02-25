# typed: false
# frozen_string_literal: true

class Notification
  class Delivery < ApplicationRecord
    key :ntfd

    belongs_to :notification
    belongs_to :recipient, polymorphic: true

    attribute :queued_at, :datetime
    attribute :sent_at, :datetime
    attribute :channel, :string

    validates :channel, presence: true, inclusion: { in: Notification::CHANNELS }
    validates :recipient_type, inclusion: { in: [User, Hook].map(&:name) }

    inquirer :channel

    scope :pending, -> { where(queued_at: nil, sent_at: nil) }
    scope :queued, -> { where.not(queued_at: nil).where(sent_at: nil) }
    scope :sent, -> { where.not(sent_at: nil) }

    after_commit :queue!, on: :create

    private

    sig { returns Notification::Job }
    def queue!
      self.queued_at = Time.current
      save!(validate: false)

      Notification::Job.perform_later(id)
    end
  end
end
