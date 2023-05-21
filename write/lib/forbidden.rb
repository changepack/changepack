# typed: false
# frozen_string_literal: true

module T
  Forbiddens = T.type_alias { ::Forbidden::RelationType }
end

class Forbidden < ApplicationRecord
  TYPES = %w[email].freeze

  key :fbd

  attribute :type, :string
  attribute :content, :string

  belongs_to :source

  validates :type, presence: true, inclusion: { in: TYPES }
  validates :content, presence: true, uniqueness: { scope: %i[type source_id] }

  inquirer :type
  delegate :email?, to: :type

  sig { returns T::Array[Forbidden] }
  def self.defaults
    [
      new(type: 'email', content: 'dependabot')
    ]
  end
end
