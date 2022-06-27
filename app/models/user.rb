# frozen_string_literal: true

class User < ApplicationRecord
  key :usr

  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  attribute :name, :string
  attribute :email, :string
  attribute :provider_ids, :jsonb, default: {}
  attribute :discarded, :datetime

  belongs_to :account

  has_many :changelogs, dependent: :nullify
  has_many :repositories, dependent: :delete_all

  accepts_nested_attributes_for :account

  validates :name, presence: true

  normalize :name
  normalize :email, with: %i[squish downcase]

  after_initialize do
    self.account = Account.new if account_id.nil?
  end

  def git?
    provider_ids.keys.any?
  end

  def access_token(provider)
    provider_ids.fetch(provider.to_s, nil)&.fetch('access_token')
  end

  def github_id
    github_ids['id']
  end

  def github_access_token
    github_ids['access_token']
  end

  def github_ids
    provider_ids['github'] || {}
  end
end
