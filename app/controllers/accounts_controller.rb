# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @account = Account.find(params.require(:id))
    authorize! @account
  end
end
