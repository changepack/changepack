# typed: false
# frozen_string_literal: true

class Filter < ApplicationRecord
  key :fil

  attribute :trait, :string
  attribute :content, :string

  belongs_to :source

  TRAITS = %w[email].freeze

  validates :trait, presence: true, inclusion: { in: TRAITS }
  validates :content, presence: true, uniqueness: { scope: %i[trait source_id] }

  inquirer :trait
  delegate :email?, to: :trait

  sig { returns T::Array[Filter] }
  def self.defaults
    [
      new(trait: 'email', content: 'dependabot')
    ]
  end
end
