# frozen_string_literal: true

class User < ApplicationRecord
  key :usr

  devise :database_authenticatable, :rememberable, :validatable

  attribute :first_name, :string
  attribute :last_name, :string

  composed_of :name, mapping: %i[email first_name last_name].map { |attr| [attr] }

  belongs_to :account
  has_many :changelogs, dependent: :nullify
  accepts_nested_attributes_for :account

  after_initialize do
    self.account = Account.new if account_id.nil?
  end
end
