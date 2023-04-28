# typed: false
# frozen_string_literal: true

module T
  Commit = T.type_alias { ::Commit }
  Commits = T.type_alias { ::Commit::RelationType }
end

class Commit < ApplicationRecord
  include Events
  include Git

  OPTIONS = T.let(
    lambda { |pt|
      Arel.sql(
        <<-SQL.squish
          CASE
            WHEN commits.post_id = '#{pt.id}' THEN 0
            ELSE 1
          END,
          commits.commited_at DESC
        SQL
      )
    },
    T.proc.params(pt: Post).returns(String)
  )

  key :com

  attribute :message, :text
  attribute :url, :string
  attribute :commited_at, :datetime
  attribute :author, Commit::Author.to_type, default: -> { {} }

  belongs_to :account
  belongs_to :changelog
  belongs_to :repository
  belongs_to :post, optional: true

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited_at, presence: true
  validates :author, presence: true, store_model: true

  normalize :message

  scope :options, ->(pt) { where(post: [pt, nil]).order(OPTIONS.call(pt)) },
        sig: T.proc.params(cl: Post)

  after_commit :created!, on: :create

  private

  def created!
    Event.publish(
      Created.new(id:, account_id:, message:)
    )
  end
end
