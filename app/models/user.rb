# frozen_string_literal: true

class User < ApplicationRecord
  include Git
  include Registration

  key :user

  attribute :name, :string
  attribute :email, :string

  belongs_to :account
  has_many :changelogs, dependent: :nullify

  accepts_nested_attributes_for :account

  normalize :name
  normalize :email, with: %i[squish downcase]
end
