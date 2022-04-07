# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  helper_method :current_account

  def current_account
    @current_account ||= current_user&.account
  end
end
