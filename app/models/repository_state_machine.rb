# frozen_string_literal: true

class RepositoryStateMachine
  include Statesman::Machine

  state :inactive, initial: true
  state :active

  transition from: :inactive, to: [:active]
  transition from: :active, to: [:inactive]

  after_transition(after_commit: true) do |model, transition|
    model.update!(status: transition.to_state)
  end
end
