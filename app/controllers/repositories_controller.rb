# frozen_string_literal: true

# Go to Users::OmniauthCallbacksController for the code that is used
# to pull repositories from GitHub and other providers after OAuth.
class RepositoriesController < ApplicationController
  def index
    pagy, repositories = pagy(scope)

    authorize! and render locals: { repositories:, pagy: }
  end

  def confirm_update
    authorize! repository, to: :update?

    render locals: { repository: }
  end

  def update
    authorize! repository and respond_to do |format|
      repository.transition_to!(:active)

      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  def confirm_destroy
    authorize! repository, to: :destroy?

    render locals: { repository: }
  end

  def destroy
    authorize! repository and respond_to do |format|
      repository.transition_to!(:inactive)

      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  private

  def repository
    @repository ||= scope.find(id)
  end

  def scope
    @scope ||= authorized(Repository.activity.kept)
  end
end
