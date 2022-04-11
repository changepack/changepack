# frozen_string_literal: true

class Changelog < ApplicationRecord
  extend FriendlyId
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

  friendly_id :slug_candidates
  normalize :title
  inquirer :status

  scope :for, ->(user) { where(user.nil? && { status: :published }) }

  private

  def slug_candidates
    %i[title_timestamp set_pretty_id]
  end

  def title_timestamp
    [title, Time.current.to_i] if title?
  end
end
