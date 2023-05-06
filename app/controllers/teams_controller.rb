# typed: false
# frozen_string_literal: true

class TeamsController < ApplicationController
  include Pullable

  private

  sig { override.returns Team }
  def resource
    @resource ||= authorized(Team.all).find(id)
  end

  sig { override.returns T::Locals }
  def item
    {
      locals: { team: resource }
    }
  end

  sig { override.params(_resource: Team).returns String }
  def after_transition_path_for(_resource)
    sources_path
  end
end
