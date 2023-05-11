# typed: false
# frozen_string_literal: true

class TeamTransition < ApplicationRecord
  key :tmt

  belongs_to :team, inverse_of: :transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  sig { returns T::Boolean }
  def update_most_recent
    last_transition = team.team_transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update!(:most_recent, true)
  end
end
