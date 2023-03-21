# typed: false
# frozen_string_literal: true

module T
  Changelog = T.type_alias { ::Changelog }
  Changelogs = T.type_alias { ::Changelog::RelationType }
end

class Changelog < ApplicationRecord
  include Publish

  include Slug
  include Status

  key :cl

  attribute :title, :string
  attribute :status, :string, default: :draft

  belongs_to :user, optional: true
  belongs_to :account

  has_many :commits, dependent: :nullify

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalize :title

  inquirer :status
  delegate :published?, to: :status

  scope :for, ->(user) { where(user.blank? && { status: :published }) },
        sig: T.proc.params(user: T.nilable(User))

  scope :recent, -> { order(created_at: :desc) }

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    [
      %i[title set_slug_pretty_id]
    ]
  end
end
