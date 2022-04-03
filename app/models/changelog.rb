# typed: false
# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Status

  key :log

  attribute :title, :string
  attribute :status, :string, default: 'draft'

  has_rich_text :content

  validates :title, length: { maximum: 140 }
  validates :content, presence: true

  normalize :title
  inquirer :status
end
