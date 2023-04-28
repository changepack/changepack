# typed: false
# frozen_string_literal: true

module T
  User = T.type_alias { ::User }
  Users = T.type_alias { ::User::RelationType }
end

class User < ApplicationRecord
  include Registration
  include Git

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
