# frozen_string_literal: true

class RepositoryTransition < ApplicationRecord
  key :rtr

  belongs_to :repository, inverse_of: :repository_transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = repository.repository_transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update!(most_recent: true)
  end
end
