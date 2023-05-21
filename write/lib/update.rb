# typed: false
# frozen_string_literal: true

module T
  Updates = T.type_alias { ::Update::RelationType }
end

class Update < ApplicationRecord
  include Options
  include Forbid

  TYPES = %w[commit issue].freeze

  key :upd

  # Refer to the following comment. We only duplicate attributes essential for
  # filters, reports, or SQL queries, such as those used to scope paginated
  # commits and issues together, for instance.
  attribute :name, :string
  attribute :type, :string
  # We use tags for search or filtering
  attribute :tags, :string, array: true, default: []

  belongs_to :account
  belongs_to :source
  belongs_to :post, optional: true
  belongs_to :changelog, optional: true
  # We are violating the guideline of avoiding cross-domain model references here,
  # as updates, commits, and issues typically change in tandem. Our goal is to
  # prevent the added complexity of caching other attributes from commits and
  # issues, which you can reference directly.
  belongs_to :commit, optional: true
  belongs_to :issue, optional: true

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :commit_id, uniqueness: { scope: :account_id }, if: :commit_id?
  validates :issue_id, uniqueness: { scope: :account_id }, if: :issue_id?

  inquirer :type
end
