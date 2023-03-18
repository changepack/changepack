# typed: false
# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  def index
    authorize! and redirect_to current_account
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
                           .recent
                           .with_rich_text_content_and_embeds
                           .includes(:user)
  end
end
