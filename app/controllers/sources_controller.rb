# typed: false
# frozen_string_literal: true

class SourcesController < ApplicationController
  def index
    authorize!
    pagy, sources = pagy(collection)

    render locals: { sources:, pagy: }
  end

  private

  sig { returns Source::RelationType }
  def collection
    authorized(Source.includes(:repository, :team).activity.kept)
  end
end
