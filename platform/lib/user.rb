# typed: false
# frozen_string_literal: true

class User < ApplicationRecord
  include Registration
  include Tokenable

  key :user

  attribute :name, :string
  attribute :email, :string

  belongs_to :account
  has_many :posts, dependent: :nullify
  has_many :access_tokens, dependent: :destroy

  accepts_nested_attributes_for :account

  normalize :name
  normalize :email, with: %i[squish downcase]
end
