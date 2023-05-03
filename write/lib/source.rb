# typed: false
# frozen_string_literal: true

module T
  Source = T.type_alias { ::Source }
  Sources = T.type_alias { ::Source::RelationType }
end

class Source < ApplicationRecord
  include Active

  TYPES = %w[repository team].freeze

  self.inheritance_column = nil

  key :src

  attribute :name, :string
  attribute :type, :string
  attribute :status, :string, default: :inactive

  belongs_to :account
  belongs_to :changelog, optional: true
  belongs_to :repository, optional: true
  belongs_to :team, optional: true
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :repository_id, uniqueness: { scope: :account_id }, if: :repository_id?
  validates :team_id, uniqueness: { scope: :account_id }, if: :team_id?

  inquirer :type
  inquirer :status
end
