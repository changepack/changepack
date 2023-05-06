# typed: false
# frozen_string_literal: true

class TeamsController < ApplicationController
  def confirm_update
    authorize! team, to: :update? and render item
  end

  def update
    authorize! team

    team.transition_to!(:active)
    redirect_to sources_path
  end

  def confirm_destroy
    authorize! team, to: :destroy? and render item
  end

  def destroy
    authorize! team

    team.transition_to!(:inactive)
    redirect_to sources_path
  end

  private

  sig { returns Team }
  def team
    @team ||= authorized(Team.all).find(id)
  end

  sig { returns T::Locals }
  def item
    {
      locals: { team: }
    }
  end
end
