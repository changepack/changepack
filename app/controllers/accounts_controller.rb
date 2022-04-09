# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    authorize! account
  end

  private

  def account
    @account ||= Account.find(params.require(:id))
  end
end
