# typed: false
# frozen_string_literal: true

class AccountsController < ApplicationController
  def index
    authorize! and redirect_to current_account
  end

  def show
    authorize! account and render locals: { account:, posts: }
  end

  private

  sig { returns Account }
  def account
    @account ||= Account.kept.friendly.find(id)
  end

  sig { returns Post::RelationType }
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
