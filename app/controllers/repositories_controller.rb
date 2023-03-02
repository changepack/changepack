# frozen_string_literal: true

class RepositoriesController < ApplicationController
  def index
    authorize!
    pagy, repositories = pagy(scope)

    render locals: { repositories:, pagy: }
  end

  def confirm_update
    authorize! repository, to: :update?

    render locals: { repository: }
  end

  def update
    authorize! repository

    repository.transition_to!(:active)

    redirect_to repositories_url
  end

  def confirm_destroy
    authorize! repository, to: :destroy?

    render locals: { repository: }
  end

  def destroy
    authorize! repository

    repository.transition_to!(:inactive)

    redirect_to repositories_url
  end

  private

  def repository
    @repository ||= scope.find(id)
  end

  def scope
    @scope ||= authorized(Repository.activity.kept)
  end
end
