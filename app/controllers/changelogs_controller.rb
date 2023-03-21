# typed: false
# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_verify_authorized only: :show
  skip_before_action :authenticate_user!, only: :show
  before_action :set_new_changelog, only: %i[new create]

  def index
    authorize! and redirect_to current_account
  end

  def show
    render item
  end

  def new
    authorize! and render form
  end

  def edit
    authorize! changelog and render form
  end

  def confirm_destroy
    authorize! changelog, to: :destroy? and render item
  end

  def create
    authorize!

    Publication.new(permitted).create!

    if changelog.valid?
      redirect_to changelog
    else
      render :new, form
    end
  end

  def update
    authorize! changelog

    Publication.new(permitted).update!

    if changelog.valid?
      redirect_to changelog
    else
      render :edit, form
    end
  end

  def destroy
    authorize! changelog

    changelog.discard
    redirect_to changelogs_url
  end

  private

  sig { returns Changelog }
  def changelog
    @changelog ||= Changelog.kept.friendly.find(id)
  end

  sig { returns T::Commits }
  def commits
    @commits ||= current_account.commits
                                .options(changelog)
                                .includes(:repository, :changelog)
                                .limit(100)
                                .kept
  end

  sig { returns Changelog }
  def set_new_changelog
    @changelog = Changelog.new
  end

  sig { returns T::Params }
  def permitted
    params.require(:changelog)
          .then { |permitted| authorized(permitted) }
          .merge(changelog:, user: current_user, account: current_account)
  end

  sig { returns T::Locals }
  def form
    {
      locals: { changelog: changelog.decorate, commits: commits.decorate }
    }
  end

  sig { returns T::Locals }
  def item
    {
      locals: { changelog: }
    }
  end
end
