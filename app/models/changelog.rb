# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Status

  key :log

  attribute :title, :string
  attribute :status, :string, default: 'draft'

  has_rich_text :content
  has_many :transitions, class_name: 'ChangelogTransition', autosave: false, dependent: :delete_all

  validates :content, presence: true

  normalize :title
  inquirer :status
end
