# typed: false
# frozen_string_literal: true

class Banned < ApplicationRecord
  self.table_name = 'banned_items'

  key :ban

  attribute :type, :string
  attribute :content, :string

  belongs_to :source

  TYPES = %w[email].freeze

  validates :type, presence: true, inclusion: { in: TYPES }
  validates :content, presence: true, uniqueness: { scope: %i[type source_id] }

  inquirer :type
  delegate :email?, to: :type

  sig { returns T::Array[Banned] }
  def self.defaults
    [
      new(type: 'email', content: 'dependabot')
    ]
  end
end
