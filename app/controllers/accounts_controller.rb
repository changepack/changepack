# typed: false
# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  def index
    authorize! and redirect_to current_account
  end

  def show
    render locals: { account:, posts: }
  end

  private

  sig { returns Account }
  def account
    @account ||= domain || friendly_id
  end

  sig { returns T.nilable(Account) }
  def domain
    Account.find_by(domain: request.host)
  end

  sig { returns Account }
  def friendly_id
    Account.kept.friendly.find(id)
  end

  sig { returns T::Posts }
  def posts
    @posts ||= account.posts
                      .for(current_user)
                      .kept
                      .recent
                      .with_rich_text_content_and_embeds
                      .includes(:user)
  end

  sig { returns String }
  def id
    params.fetch(:account_id)
  end
end
