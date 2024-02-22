# typed: false
# frozen_string_literal: true

class Filter < ApplicationRecord
  key :fil

  attribute :trait, :string
  attribute :content, :string
  attribute :type, :string, default: :reject

  belongs_to :source

  TRAITS = %w[email].freeze
  TYPES = %w[reject select].freeze

  validates :type, presence: true, inclusion: { in: TYPES }
  validates :trait, presence: true, inclusion: { in: TRAITS }
  validates :content, presence: true, uniqueness: { scope: %i[trait type source_id] }

  inquirer :trait
  inquirer :type

  delegate :email?, to: :trait
  delegate :reject?, :select?, to: :type

  sig { returns T::Array[Filter] }
  def self.defaults
    [
      new(type: :reject, trait: :email, content: 'dependabot')
    ]
  end
end
