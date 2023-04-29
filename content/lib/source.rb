# typed: false
# frozen_string_literal: true

module T
  Source = T.type_alias { ::Source }
  Sources = T.type_alias { ::Source::RelationType }
end

class Source < ApplicationRecord
  include Active

  TYPES = %w[repository].freeze

  self.inheritance_column = false

  key :src

  attribute :name, :string
  attribute :type, :string
  attribute :status, :string, default: :inactive

  belongs_to :account
  belongs_to :repository, optional: true

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :repository_id, uniqueness: { scope: :account_id }

  inquirer :status
end
