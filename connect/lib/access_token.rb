# typed: false
# frozen_string_literal: true

module T
  AccessToken = T.type_alias { ::AccessToken }
  AccessTokens = T.type_alias { ::AccessToken::RelationType }
end

class AccessToken < ApplicationRecord
  key :tok

  attribute :provider, :string
  attribute :token, :string

  belongs_to :user
  belongs_to :account
  has_many :repositories, dependent: :nullify

  validates :token, presence: true, uniqueness: { scope: %i[account_id provider] }
  validates :provider, presence: true

  after_initialize do
    self.account ||= user&.account if user_id.present?
  end

  sig { returns String }
  def to_s
    token
  end

  sig { params(provider: T::Key, auth: OmniAuth::AuthHash, user: User).returns(AccessToken) }
  def self.from!(provider, auth:, user:)
    AccessToken.find_or_create_by!(
      token: auth.credentials.token,
      account: user.account,
      provider:,
      user:
    )
  end
end
