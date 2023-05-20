# typed: false
# frozen_string_literal: true

module T
  module API
    Key = T.type_alias { ::API::Key }
    Keys = T.type_alias { ::API::Key::RelationType }
  end
end

module API
  class Key < ApplicationRecord
    key :api

    attribute :token, :string
    attribute :last_used_at, :datetime

    belongs_to :account

    validates :token, presence: true, uniqueness: true
    encrypts :token, deterministic: true

    after_initialize do
      self.token ||= SecureRandom.hex(32)
    end
  end
end
