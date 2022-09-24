# frozen_string_literal: true
# typed: strict

class Changelog < ApplicationRecord
  include Slug
  include Status

  key :log

  attribute :title, :string
  attribute :status, :string, default: :draft
  attribute :discarded, :datetime

  belongs_to :user, optional: true
  belongs_to :account

  has_many :commits, dependent: :nullify

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalize :title

  inquirer :status

  scope :for, ->(user) { where(!user && { status: :published }) }
  scope :recent, -> { order(created_at: :desc) }

  private

  sig { returns(T::Array[T::Array[Symbol]]) }
  def slug_candidates
    [
      %i[title set_slug_pretty_id]
    ]
  end
end
