# typed: false
# frozen_string_literal: true

module Domain
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  abstract!

  sig { params(request: ActionDispatch::Request).returns(T::Boolean) }
  def self.matches?(request)
    request.subdomain.present? && matching_changelog?(request)
  end

  sig { params(request: ActionDispatch::Request).returns(T::Boolean) }
  def self.matching_changelog?(request)
    Changelog.where(domain: request.host).any?
  end

  included do
    attribute :domain, :string

    validates :domain, presence: true, uniqueness: true, if: :domain?
    validate :valid_domain
  end

  private

  sig { overridable.returns T.nilable(ActiveModel::Error) }
  def valid_domain
    return if domain.blank?

    domain_regex = /\A[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/ix

    return if domain.match?(domain_regex)

    errors.add(:domain, 'is not a valid domain format')
  end
end
