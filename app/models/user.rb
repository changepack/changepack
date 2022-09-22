# frozen_string_literal: true
# typed: strict

class User < ApplicationRecord
  include Provider

  key :usr

  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  attribute :name, :string
  attribute :email, :string
  attribute :discarded, :datetime

  belongs_to :account

  has_many :changelogs, dependent: :nullify
  has_many :repositories, dependent: :delete_all

  accepts_nested_attributes_for :account

  validates :name, presence: true

  normalize :name
  normalize :email, with: %i[squish downcase]

  provider :github, :id
  provider :github, :access_token

  after_initialize :set_account

  sig { returns(T.nilable(String)) }
  def access_token
    providers.dig(provider, :access_token)
  end

  sig { returns(T::Boolean) }
  def git?
    providers.present?
  end

  private

  sig { returns(Account) }
  def set_account
    self.account ||= Account.new
  end
end
