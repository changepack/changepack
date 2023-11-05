# typed: false
# frozen_string_literal: true

class Update < ApplicationRecord
  include Options
  include Forbid
  include Events

  TYPES = %w[commit issue].freeze

  key :upd

  # Refer to the following comment. We only duplicate attributes essential for
  # filters, reports, or SQL queries, such as those used to scope paginated
  # commits and issues together, for instance.
  attribute :name, :string
  # Context provides additional information about the update, such as the
  # a long-form summary of changes introduced in the commit or issue
  attribute :context, :string
  attribute :type, :string
  # We use tags for search or filtering
  attribute :tags, :string, array: true, default: []
  attribute :sourced_at, :datetime

  belongs_to :account
  belongs_to :source
  belongs_to :post, optional: true
  belongs_to :newsletter, optional: true
  # We are violating the guideline of avoiding cross-domain model references here,
  # as updates, commits, and issues typically change in tandem. Our goal is to
  # prevent the added complexity of caching other attributes from commits and
  # issues, which you can reference directly.
  belongs_to :commit, optional: true
  belongs_to :issue, optional: true

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :sourced_at, presence: true
  validates :commit_id, uniqueness: { scope: :account_id }, if: :commit_id?
  validates :issue_id, uniqueness: { scope: :account_id }, if: :issue_id?

  scope :desc, -> { order(sourced_at: :desc) }

  inquirer :type

  after_commit :created!, on: :create
  after_commit :updated!, on: :update

  def prompt = context || name

  private

  sig { returns String }
  def created!
    pub Upserted.new(id:)
  end

  sig { returns String }
  def updated!
    pub Upserted.new(id:)
  end
end
