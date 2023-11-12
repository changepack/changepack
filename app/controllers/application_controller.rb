# typed: false
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  prepend ActionPolicy::Draper
  include Pagy::Backend
  extend T::Sig

  verify_authorized
  protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_raven_context

  helper_method :user_signed_out?
  helper_method :disallowed_to?
  helper_method :pagy_array
  helper_method :pagy

  layout -> { ApplicationLayout }

  private

  sig { returns T.nilable(account_id: String, user_id: String) }
  def set_raven_context
    Sentry.set_user(account_id: Current.account.id, user_id: Current.user.id) if user_signed_in?
  end

  sig { returns T.nilable(User) }
  def set_current_user
    Current.user = current_user if user_signed_in?
  end

  sig { returns T.nilable(String) }
  def id
    params.require(:id)
  end

  def disallowed_to?(rule, record = :__undef__, **options)
    !allowed_to?(rule, record, **options)
  end

  sig { returns T::Boolean }
  def user_signed_out?
    !user_signed_in?
  end
end
