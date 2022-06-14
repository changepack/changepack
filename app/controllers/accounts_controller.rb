# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @account = Account.friendly.find(id)
    @changelogs = @account.changelogs
                          .for(current_user)
                          .desc
                          .with_rich_text_content_and_embeds
                          .includes(:user)

    authorize! @account
  end
end
