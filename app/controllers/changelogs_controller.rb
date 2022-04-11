# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  skip_verify_authorized

  before_action :set_changelog, only: %i[edit update confirm_destroy destroy]
  before_action only: %i[edit update destroy] do
    authorize! @changelog
  end

  def index
    respond_to do |format|
      format.html { redirect_to account_path(current_account) }
      format.json { render :index, locals: { changelogs: } }
    end
  end

  def show
    @changelog = Changelog.friendly.find(params.require(:id))
  end

  def new
    @changelog = Changelog.new
  end

  def edit; end

  def create
    @changelog = Changelog.new

    respond_to do |format|
      if Changelogs::Upsert.new(**changelog_params).perform
        format.html { redirect_to changelog_url(@changelog) }
        format.json { render :show, status: :created, location: @changelog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if Changelogs::Upsert.new(**changelog_params).perform
        format.html { redirect_to changelog_url(@changelog) }
        format.json { render :show, status: :ok, location: @changelog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm_destroy; end

  def destroy
    @changelog.destroy

    respond_to do |format|
      format.html { redirect_to changelogs_url }
      format.json { head :no_content }
    end
  end

  private

  def set_changelog
    @changelog = changelogs.friendly.find(params.require(:id))
  end

  def changelogs
    @changelogs ||= authorized_scope(Changelog.all)
  end

  def changelog_params
    params.require(:changelog)
          .permit(:title, :content, :published)
          .merge(changelog: @changelog, user: current_user)
          .to_h
  end
end
