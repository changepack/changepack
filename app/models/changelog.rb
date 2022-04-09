# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Status

  key :log

  attribute :title, :string
  attribute :status, :string, default: 'draft'

  belongs_to :user, optional: true
  belongs_to :account

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalize :title
  inquirer :status

  scope :for, ->(user) { where(user.nil? && { status: :published }) }
end
