# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Slug
  include Status

  key :log

  attribute :title, :string
  attribute :status, :string, default: :draft

  belongs_to :user, optional: true
  belongs_to :account

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true
  validates :status, presence: true

  normalize :title

  inquirer :status

  scope :for, ->(user) { where(!user && { status: :published }) }

  private

  def slug_candidates
    [
      %i[title set_pretty_id]
    ]
  end
end
