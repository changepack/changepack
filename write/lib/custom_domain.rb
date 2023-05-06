# typed: false
# frozen_string_literal: true

module CustomDomain
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
    Changelog.where(custom_domain: request.host).any?
  end

  included do
    attribute :custom_domain, :string

    validates :custom_domain, presence: true, uniqueness: true, if: :custom_domain?
    validate :valid_custom_domain
  end

  private

  sig { overridable.returns T.nilable(ActiveModel::Error) }
  def valid_custom_domain
    return if custom_domain.blank?

    domain_regex = /\A[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/ix

    return if custom_domain.match?(domain_regex)

    errors.add(:custom_domain, 'is not a valid domain format')
  end
end
