# typed: false
# frozen_string_literal: true

module T
  Change = T.type_alias { ::Change }
  Changes = T.type_alias { ::Change::RelationType }
end

class Change < ApplicationRecord
  TYPES = %w[commit].freeze

  self.inheritance_column = false

  key :cha

  attribute :message, :string
  attribute :type, :string

  belongs_to :account
  belongs_to :commit

  validates :message, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :commit_id, uniqueness: { scope: :account_id }
end
