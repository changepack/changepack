# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  skip_verify_authorized

  before_action only: %i[edit update destroy] do
    authorize! changelog
  end

  def index
    redirect_to account_path(current_account)
  end

  def new
    render locals: { changelog: Changelog.new }
  end

  def show
    render(**common_locals)
  end

  def edit
    render(**common_locals)
  end

  def confirm_destroy
    render(**common_locals)
  end

  def create
    changelog = Changelogs::Upsert.new(**create_changelog_params).execute

    respond_to do |format|
      if changelog.valid?
        format.html { redirect_to changelog_url(changelog) }
        format.json { render :show, locals: { changelog: }, status: :created, location: changelog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    changelog = Changelogs::Upsert.new(**update_changelog_params).execute

    respond_to do |format|
      if changelog.valid?
        format.html { redirect_to changelog_url(changelog) }
        format.json { render :show, status: :ok, location: changelog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    changelog.destroy

    respond_to do |format|
      format.html { redirect_to changelogs_url }
      format.json { head :no_content }
    end
  end

  private

  def changelog
    @changelog ||= Changelog.friendly.find(id)
  end

  def create_changelog_params
    params.require(:changelog)
          .permit(:title, :content, :published)
          .merge(user: current_user, changelog: Changelog.new)
          .to_h
  end

  def update_changelog_params
    create_changelog_params.merge(changelog:)
  end

  def common_locals
    { locals: { changelog: } }
  end
end
