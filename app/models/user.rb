# frozen_string_literal: true

class User < ApplicationRecord
  key :usr

  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  attribute :name, :string
  attribute :email, :string
  attribute :external_ids, :jsonb, default: {}

  belongs_to :account
  has_many :changelogs, dependent: :nullify

  accepts_nested_attributes_for :account

  validates :name, presence: true

  normalize :name
  normalize :email, with: %i[squish downcase]

  after_initialize do
    self.account = Account.new if account_id.nil?
  end

  def github_id
    github_ids['id']
  end

  def github_access_token
    github_ids['access_token']
  end

  def github_ids
    external_ids['github'] || {}
  end
end
