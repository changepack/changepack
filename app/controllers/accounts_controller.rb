# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_verify_authorized

  def show
    render locals: { account:, changelogs: }
  end

  private

  def account
    @account ||= Account.friendly.find(id)
  end

  def changelogs
    @changelogs ||= account.changelogs
                           .for(current_user)
                           .desc
                           .with_rich_text_content_and_embeds
                           .includes(:user)
  end
end
