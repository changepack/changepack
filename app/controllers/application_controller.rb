# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  verify_authorized

  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  helper_method :current_account

  def current_account
    @current_account ||= current_user&.account
  end

  def id
    params.require(:id)
  end
end
