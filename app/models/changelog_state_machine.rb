class ChangelogStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :published

  transition from: :draft, to: [:published]

  after_transition(after_commit: true) do |model, transition|
    model.update!(status: transition.to_state)
  end
end
