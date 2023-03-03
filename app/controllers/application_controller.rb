# frozen_string_literal: true

class ApplicationController < ActionController::Base
  prepend ActionPolicy::Draper
  include Pagy::Backend

  verify_authorized

  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user!

  helper_method :current_account
  helper_method :disallowed_to?
  helper_method :pagy_array
  helper_method :pagy

  layout -> { ApplicationLayout }

  private

  def current_account
    @current_account ||= current_user&.account
  end

  def id
    params.require(:id)
  end

  def disallowed_to?(action, resource)
    !helpers.allowed_to?(action, resource)
  end
end
