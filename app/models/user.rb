# typed: false
# frozen_string_literal: true

class User < ApplicationRecord
  key :usr

  devise :database_authenticatable, :rememberable, :validatable

  attribute :first_name, :string
  attribute :last_name, :string

  composed_of :name, mapping: %i[email first_name last_name].map { |attr| [attr] }

  has_many :changelogs, dependent: :nullify
end
