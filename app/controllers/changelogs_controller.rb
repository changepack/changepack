# typed: false
# frozen_string_literal: true

class ChangelogsController < ApplicationController
  before_action :set_new_changelog, only: %i[new create]
  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  delegate :account, to: :changelog
  visited :account, only: :show

  def index
    authorize! and render locals: { changelogs: }
  end

  def show
    render locals: { account:, posts: }
  end

  def new
    authorize! and render form
  end

  def edit
    authorize! changelog and render form
  end

  def create
    authorize!
    changelog.update(permitted)

    if changelog.valid?
      redirect_to changelogs_path
    else
      render :new, form
    end
  end

  def update
    authorize! changelog
    changelog.update(permitted)

    if changelog.valid?
      redirect_to changelogs_path
    else
      render :edit, form
    end
  end

  private

  sig { returns T.nilable(Account) }
  def domain
    Account.find_by(domain: request.host)
  end

  sig { returns Account }
  def friendly_id
    Account.kept.friendly.find params.fetch(:account_id)
  end

  sig { returns Hash }
  def form
    {
      locals: { changelog: changelog.decorate },
      layout: ->(_, _) { FormLayout }
    }
  end

  sig { returns T::Params }
  def permitted
    authorized params.require(:changelog)
  end

  sig { returns Changelog }
  def set_new_changelog
    @changelog = current_account.changelogs.new
  end

  sig { returns Account }
  def account
    @account ||= domain || friendly_id
  end

  sig { returns Changelog::RelationType }
  def changelogs
    @changelogs ||= current_account.changelogs.kept.desc
  end

  sig { returns Changelog }
  def changelog
    @changelog ||= changelogs.friendly.find(id)
  end

  sig { returns Changelog }
  def scoped
    @scoped ||= account.changelogs.kept.friendly.find(id)
  end

  sig { returns Post::RelationType }
  def posts
    @posts ||= scoped.posts
                     .for(current_user)
                     .kept
                     .recent
                     .with_rich_text_content_and_embeds
                     .includes(:user)
  end
end
