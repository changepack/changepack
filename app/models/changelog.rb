# typed: false
# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Status

  key :log

  has_rich_text :content
  attribute :title, :string
  attribute :status, :string, default: 'draft'

  belongs_to :user, optional: true

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalize :title
  inquirer :status
end
