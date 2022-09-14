# frozen_string_literal: true

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

  after_initialize do
    self.account ||= Account.new if account.nil?
  end

  def access_token
    providers.dig(provider, :access_token)
  end

  def git?
    providers.present?
  end
end
