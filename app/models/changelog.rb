# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Status

  key :log

  attribute :title, :string
  attribute :status, :string

  has_rich_text :content
  has_many :transitions, class_name: 'ChangelogTransition', autosave: false

  validates :content, presence: true

  normalize :title
  inquirer :status
end
