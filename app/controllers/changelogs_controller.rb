# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_verify_authorized

  before_action only: %i[edit update destroy] do
    authorize! changelog
  end

  def index
    redirect_to account_path(current_account)
  end

  def new
    @changelog = Changelog.new

    render(**form_locals)
  end

  def show
    render(**show_locals)
  end

  def edit
    render(**form_locals)
  end

  def confirm_destroy
    render(**show_locals)
  end

  def create
    changelog = upsert!(create_params)

    respond_to do |format|
      if changelog.valid?
        format.html { redirect_to changelog }
        format.json { render :show, **show_locals(status: :created, location: changelog) }
      else
        format.html { render :new, **form_locals(status: :unprocessable_entity) }
        format.json { render json: changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    changelog = upsert!(update_params)

    respond_to do |format|
      if changelog.valid?
        format.html { redirect_to changelog }
        format.json { render :show, **show_locals(status: :ok, location: changelog) }
      else
        format.html { render :edit, **form_locals(status: :unprocessable_entity) }
        format.json { render json: changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    changelog.discard

    respond_to do |format|
      format.html { redirect_to changelogs_url }
      format.json { head :no_content }
    end
  end

  private

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

  def upsert!(params)
    Changelogs::Upsert.new(**params).execute
  end

  def create_params
    params.require(:changelog)
          .permit(:title, :content, :published, commit_ids: [])
          .to_h
          .merge(user: current_user, changelog: Changelog.new)
  end

  def update_params
    create_params.merge(changelog:)
  end

  def form_locals(opts = {})
    {
      locals: {
        changelog: changelog.decorate,
        commits: commits.decorate
      }
    }.merge(opts)
  end

  def show_locals(opts = {})
    {
      locals: {
        changelog: changelog.decorate
      }
    }.merge(opts)
  end
end
