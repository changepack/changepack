# frozen_string_literal: true

# Go to Users::OmniauthCallbacksController for the code that is used
# to pull repositories from GitHub and other providers after OAuth.
class RepositoriesController < ApplicationController
  before_action { authorize! }

  def index
    pagy, repositories = pagy(scope)

    render locals: { repositories:, pagy: }
  end

  def confirm_update
    render locals: { repository: }
  end

  def update
    repository.transition_to!(:active)

    Event.publish(
      Repositories::Outdated.new(data: { repository: repository.id })
    )

    respond_to do |format|
      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  def confirm_destroy
    render locals: { repository: }
  end

  def destroy
    repository.transition_to!(:inactive)

    respond_to do |format|
      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  private

  def repository
    @repository ||= scope.find(id)
  end

  def scope
    @scope ||= authorized_scope(Repository.activity.kept)
  end
end
