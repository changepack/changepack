# typed: false
# frozen_string_literal: true

class RepositoriesController < ApplicationController
  include Pullable

  private

  sig { override.returns Repository }
  def resource
    @resource ||= authorized(Repository.all).find(id)
  end

  sig { override.returns T::Locals }
  def item
    {
      locals: { repository: resource }
    }
  end

  sig { override.params(_resource: Repository).returns String }
  def after_transition_path_for(_resource)
    sources_path
  end
end
