# typed: false
# frozen_string_literal: true

class RepositoryTransition < ApplicationRecord
  key :rtr

  belongs_to :repository, inverse_of: :transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  sig { returns T::Boolean }
  def update_most_recent
    last_transition = repository.transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update!(most_recent: true)
  end
end
