# frozen_string_literal: true

class Account < ApplicationRecord
  key :acc

  attribute :name, :string

  has_many :users, dependent: :destroy

  normalize :name
end
