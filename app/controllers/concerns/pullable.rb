# typed: false
# frozen_string_literal: true

module Pullable
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  interface!

  def confirm_update
    authorize! resource, to: :update? and render item
  end

  def update
    authorize! resource

    resource.transition_to!(:active)
    redirect_to after_transition_path_for(resource)
  end

  def confirm_destroy
    authorize! resource, to: :destroy? and render item
  end

  def destroy
    authorize! resource

    resource.transition_to!(:inactive)
    redirect_to after_transition_path_for(resource)
  end

  private

  sig { abstract.returns ApplicationRecord }
  def resource; end

  sig { abstract.returns T::Locals }
  def item; end

  sig { abstract.params(resource: T.untyped).returns String }
  def after_transition_path_for(resource); end
end
