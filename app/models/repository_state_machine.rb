# frozen_string_literal: true

class RepositoryStateMachine
  include Statesman::Machine

  state :active, initial: true
  state :inactive

  transition from: :active, to: [:inactive]
  transition from: :inactive, to: [:active]

  after_transition(after_commit: true) do |model, transition|
    model.update!(status: transition.to_state)
  end
end
