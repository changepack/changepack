# typed: false
# frozen_string_literal: true

class User < ApplicationRecord
  include Registration
  include Tokenable

  key :user

  attribute :name, :string
  attribute :email, :string

  belongs_to :account, optional: true
  has_many :posts, dependent: :nullify
  has_many :access_tokens, dependent: :destroy

  accepts_nested_attributes_for :account

  normalizes :name, with: ->(name) { name.squish }
  normalizes :email, with: ->(email) { email.squish.downcase }
end
