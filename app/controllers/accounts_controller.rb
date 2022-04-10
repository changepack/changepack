# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @account = Account.find(params.require(:id))
    @changelogs = @account.changelogs
                          .for(current_user)
                          .includes(:user)
                          .order(created_at: :desc)
                          .with_rich_text_content_and_embeds

    authorize! @account
  end
end
