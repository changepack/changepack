# typed: false
# frozen_string_literal: true

module API
  class Key < ApplicationRecord
    key :api

    attribute :token, :string
    attribute :last_used_at, :datetime

    belongs_to :bearer, polymorphic: true

    validates :token, presence: true, uniqueness: true
    encrypts :token, deterministic: true

    after_initialize do
      self.token ||= SecureRandom.hex(21)
    end
  end
end
