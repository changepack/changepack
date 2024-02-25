# typed: false
# frozen_string_literal: true

class Post < ApplicationRecord
  include Publish
  include Events
  include Status
  include Slug

  key :pt

  attribute :title, :string
  attribute :status, :string, default: :draft

  belongs_to :user, optional: true
  belongs_to :newsletter
  belongs_to :account

  has_many :updates, dependent: :nullify

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalizes :title, with: ->(title) { title.squish }

  inquirer :status
  delegate :draft?, :published?, to: :status

  scope :recent, lambda {
    order(
      Arel.sql('COALESCE(published_at, created_at) DESC')
    )
  }

  before_save do
    self.account ||= newsletter.account
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
