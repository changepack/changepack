# frozen_string_literal: true

# Go to Users::OmniauthCallbacksController for the code that is used
# to pull repositories from GitHub and other providers after OAuth.
class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[show destroy]
  before_action { authorize! }

  def index
    @repositories = repositories
  end

  def show; end

  def update
    @repository.transition_to!(:active)

    respond_to do |format|
      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  def destroy
    @repository.transition_to!(:inactive)

    respond_to do |format|
      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  private

  def set_repository
    @repository = repositories.find(params[:id])
  end

  def repositories
    @repositories ||= authorized_scope(Repository.all)
  end
end
