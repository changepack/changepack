class Changelog < ApplicationRecord
  key :log

  attribute :title, :string
  attribute :body, :text

  validates :title, presence: true
  validates :body, presence: true
end
