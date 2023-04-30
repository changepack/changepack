# typed: false
# frozen_string_literal: true

module T
  Commit = T.type_alias { ::Commit }
  Commits = T.type_alias { ::Commit::RelationType }
end

class Commit < ApplicationRecord
  include Events
  include Git

  key :com

  attribute :message, :text
  attribute :url, :string
  attribute :commited_at, :datetime
  attribute :author, Commit::Author.to_type, default: -> { {} }

  belongs_to :account
  belongs_to :repository

  validates :message, presence: true
  validates :url, presence: true, url: true
  validates :commited_at, presence: true
  validates :author, presence: true, store_model: true

  normalize :message

  after_commit :created!, on: :create

  private

  sig { returns String }
  def created!
    pub Created.new(id:, account_id:, repository_id:, message:)
  end
end
