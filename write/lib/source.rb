# typed: false
# frozen_string_literal: true

module T
  Sources = T.type_alias { ::Source::RelationType }
end

class Source < ApplicationRecord
  include Forbid
  include Active

  TYPES = %w[repository team].freeze

  key :src

  # Refer to the following comment. We only duplicate attributes essential for
  # filters, reports, or SQL queries, such as those used to scope paginated
  # repositories and teams together, for instance.
  attribute :name, :string
  attribute :type, :string
  # Status is derived from the repository or team
  attribute :status, :string, default: :inactive

  belongs_to :account
  belongs_to :changelog, optional: true
  # We are violating the guideline of avoiding cross-domain model references here,
  # as sources, repositories, and teams typically change in tandem. Our goal is to
  # prevent the added complexity of caching other attributes from repositories
  # and teams, which you can reference directly.
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
