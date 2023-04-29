# typed: false
# frozen_string_literal: true

class RepositoriesController < ApplicationController
  def confirm_update
    authorize! repository, to: :update? and render item
  end

  def update
    authorize! repository

    repository.transition_to!(:active)
    redirect_to sources_path
  end

  def confirm_destroy
    authorize! repository, to: :destroy? and render item
  end

  def destroy
    authorize! repository

    repository.transition_to!(:inactive)
    redirect_to sources_path
  end

  private

  sig { returns Repository }
  def repository
    @repository ||= authorized(Repository.all).find(id)
  end

  sig { returns T::Locals }
  def item
    {
      locals: { repository: }
    }
  end
end
