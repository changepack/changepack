# frozen_string_literal: true

class ApplicationController < ActionController::Base
  prepend ActionPolicy::Draper
  include Pagy::Backend

  verify_authorized

  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user!

  helper_method :current_account

  private

  def current_account
    @current_account ||= current_user&.account
  end

  def id
    params.require(:id)
  end
end
