# typed: false
# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  delegate :account, to: :changelog
  visited :account

  def show
    render locals: { account:, posts: }
  end

  private

  sig { returns Changelog }
  def changelog
    @changelog ||= account.changelogs.kept.friendly.find(id)
  end

  sig { returns Account }
  def account
    domain || friendly_id
  end

  sig { returns T.nilable(Changelog) }
  def domain
    Account.find_by(domain: request.host)
  end

  sig { returns Changelog }
  def friendly_id
    Account.kept.friendly.find params.fetch(:account_id)
  end

  sig { returns Post::RelationType }
  def posts
    @posts ||= changelog.posts
                        .for(current_user)
                        .kept
                        .recent
                        .with_rich_text_content_and_embeds
                        .includes(:user)
  end
end
