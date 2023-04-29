# typed: false
# frozen_string_literal: true

class SourcesController < ApplicationController
  def index
    authorize!
    pagy, sources = pagy(collection)

    render locals: { sources:, pagy: }
  end

  private

  sig { returns T::Sources }
  def collection
    authorized(Source.includes(:repository).activity.kept)
  end
end
