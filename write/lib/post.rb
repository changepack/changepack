# typed: false
# frozen_string_literal: true

module T
  Post = T.type_alias { ::Post }
  Posts = T.type_alias { ::Post::RelationType }
end

class Post < ApplicationRecord
  include Publish
  include Status
  include Slug

  key :pt

  attribute :title, :string
  attribute :status, :string, default: :draft

  belongs_to :user, optional: true
  belongs_to :changelog
  belongs_to :account

  has_many :updates, dependent: :nullify

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalize :title

  inquirer :status
  delegate :draft?, :published?, to: :status

  scope :for, ->(user) { where(user.blank? && { status: :published }) },
        sig: T.proc.params(user: T.nilable(User))

  scope :recent, -> { order(created_at: :desc) }

  before_save do
    self.account ||= changelog.account
  end

  sig { returns String }
  def description
    content.to_plain_text.truncate(140)
  end

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    [
      %i[title set_slug_pretty_id]
    ]
  end
end
