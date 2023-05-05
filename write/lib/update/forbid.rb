# typed: false
# frozen_string_literal: true

class Update
  module Forbid
    extend ActiveSupport::Concern
    extend T::Sig

    included do
      validate :valid_unforbidden_emails, on: :create
    end

    sig { returns T.nilable(ActiveModel::Error) }
    def valid_unforbidden_emails
      return unless source

      forbidden = source.forbiddens.select(&:email?).map(&:content)
      return if forbidden.none? { |regexp| email =~ Regexp.new(regexp) }

      errors.add(:email, 'matches a forbidden keyword')
    end
  end
end
