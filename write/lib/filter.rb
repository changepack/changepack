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

  sig { params(value: String).returns(T::Boolean) }
  def =~(value)
    return false if value.blank?
    return false if content.blank?

    !!(value =~ Regexp.new(content))
  end


  sig { params(other: T::Array[String]).returns(T::Array[String]) }
  def &(other)
    other.select { |value| value =~ self }
  end

  sig { returns T::Array[Filter] }
  def self.defaults
    [
      new(type: :reject, trait: :email, content: 'dependabot')
    ]
  end
end
