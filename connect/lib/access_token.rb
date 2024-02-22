# typed: false
# frozen_string_literal: true

class AccessToken < ApplicationRecord
  key :tok

  attribute :type, :string
  attribute :token, :string

  belongs_to :user
  belongs_to :account
  has_many :repositories, dependent: :nullify
  has_many :teams, dependent: :nullify

  validates :token, presence: true, uniqueness: { scope: %i[account_id type] }
  validates :type, presence: true

  before_save do
    self.account ||= user.account if user_id.present?
  end

  sig { returns String }
  def to_s
    token
  end

  sig { returns Provider }
  def provider
    @provider ||= Provider[type].new(access_token: self)
  end
end
