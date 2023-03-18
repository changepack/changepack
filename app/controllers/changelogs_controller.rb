# typed: false
# frozen_string_literal: true

class ChangelogsController < ApplicationController
  SET_NEW = %i[new create].freeze
  AUTHORIZE_ITEM = %i[edit update destroy].freeze

  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  before_action :set_new_changelog, only: SET_NEW
  before_action(only: AUTHORIZE_ITEM) { authorize! changelog }

  def index
    authorize! and redirect_to current_account
  end

  def show
    render item
  end

  def new
    render form
  end

  def edit
    render form
  end

  def confirm_destroy
    authorize! changelog, to: :destroy? and render item
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
                                .options(changelog)
                                .includes(:repository, :changelog)
                                .limit(100)
                                .kept
  end

  def permitted
    params.require(:changelog)
          .then { |permitted| authorized(permitted) }
          .merge(changelog:, user: current_user, account: current_account)
  end

  def form
    {
      locals: { changelog: changelog.decorate, commits: commits.decorate }
    }
  end

  def item
    {
      locals: { changelog: }
    }
  end
end
