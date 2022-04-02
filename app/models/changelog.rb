# frozen_string_literal: true

class Changelog < ApplicationRecord
  key :log

  attribute :title, :string

  has_rich_text :content

  validates :content, presence: true
end
