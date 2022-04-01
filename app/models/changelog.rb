class Changelog < ApplicationRecord
  key :log

  attribute :title, :string

  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true
end
