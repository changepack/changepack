# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_verify_authorized

  def index
    redirect_to current_account
  end

  def show
    render locals: { account:, changelogs: }
  end

  private

  def account
    @account ||= Account.kept.friendly.find(id)
  end

  def changelogs
    @changelogs ||= account.changelogs
                           .for(current_user)
                           .kept
                           .desc
                           .with_rich_text_content_and_embeds
                           .includes(:user)
  end
end
