# typed: false
# frozen_string_literal: true

class TeamStateMachine
  include Statesman::Machine

  state :inactive, initial: true
  state :active

  transition from: :inactive, to: [:active]
  transition from: :active, to: [:inactive]

  after_transition(after_commit: true) do |team, transition|
    team.update!(status: transition.to_state)
  end

  after_transition(to: :active, after_commit: true) do |team, _|
    Event.publish(
      Team::Outdated.new(team_id: team.id)
    )
  end
end
