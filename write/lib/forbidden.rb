# typed: false
# frozen_string_literal: true

module T
  Forbidden = T.type_alias { ::Forbidden }
  Forbiddens = T.type_alias { ::Forbidden::RelationType }
end

class Forbidden < ApplicationRecord
  TYPES = %w[email].freeze

  key :fbd

  attribute :type, :string
  attribute :content, :string

  belongs_to :changelog

  validates :type, presence: true, inclusion: { in: TYPES }
  validates :content, presence: true, uniqueness: { scope: %i[type changelog_id] }

  inquirer :type
end
