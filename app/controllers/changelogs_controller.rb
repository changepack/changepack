# frozen_string_literal: true

class ChangelogsController < ApplicationController
  before_action :set_changelog, only: %i[show edit update confirm_destroy destroy]

  def index
    @pagy, @changelogs = pagy(
      Changelog.includes(:user)
               .order(created_at: :desc)
               .with_rich_text_content
    )
  end

  def show; end

  def new
    @changelog = Changelog.new
  end

  def edit; end

  def create
    @changelog = Changelog.new

    respond_to do |format|
      if Changelogs::Upsert.new(changelog_params).perform
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
      if Changelogs::Upsert.new(changelog_params).perform
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
    @changelog = Changelog.find(params[:id])
  end

  def changelog_params
    params.require(:changelog)
          .permit(:title, :content, :published)
          .merge(changelog: @changelog, user: current_user)
  end
end
