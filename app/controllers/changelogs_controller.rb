# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  before_action :set_new_changelog, only: %i[new create]
  before_action only: %i[edit update destroy] do
    authorize! changelog
  end

  def index
    authorize!
    redirect_to current_account
  end

  def new
    render form
  end

  def show
    render item
  end

  def edit
    render form
  end

  def confirm_destroy
    authorize! changelog, to: :destroy?
    render item
  end

  def create
    Publication.new(permitted).create!

    if changelog.valid?
      redirect_to changelog
    else
      render :new, form
    end
  end

  def update
    Publication.new(permitted).update!

    if changelog.valid?
      redirect_to changelog
    else
      render :edit, form
    end
  end

  def destroy
    changelog.discard
    redirect_to changelogs_url
  end

  private

  def set_new_changelog
    authorize!

    @changelog = Changelog.new
  end

  def changelog
    @changelog ||= Changelog.kept.friendly.find(id)
  end

  def commits
    @commits ||= current_account.commits
                                .review(changelog)
                                .includes(:repository, :changelog)
                                .limit(100)
                                .commited(changelog)
                                .kept
  end

  def permitted
    authorized(params.require(:changelog)).merge(
      changelog:,
      user: current_user,
      account: current_account
    )
  end

  def form
    {
      locals: { changelog: changelog.decorate, commits: commits.decorate }
    }
  end

  def item
    {
      locals: { changelog: changelog.decorate }
    }
  end
end
