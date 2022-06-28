# frozen_string_literal: true

class ChangelogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_verify_authorized only: :show

  def index
    authorize! and redirect_to(current_account)
  end

  def new
    @changelog = Changelog.new

    authorize! and render(**form_locals)
  end

  def show
    render(**show_locals)
  end

  def edit
    authorize! changelog and render(**form_locals)
  end

  def confirm_destroy
    authorize! changelog, to: :destroy?

    render(**show_locals)
  end

  def create
    authorize! and respond_to do |format|
      changelog = upsert!(create_params)

      if changelog.valid?
        format.html { redirect_to changelog }
        format.json { render :show, **show_locals(status: :created, location: changelog) }
      else
        format.html { render :new, **form_locals(status: :unprocessable_entity) }
        format.json { render json: changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update # rubocop:disable Metrics/AbcSize
    authorize! changelog and respond_to do |format|
      changelog = upsert!(update_params)

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
    authorize! changelog and respond_to do |format|
      changelog.discard

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
