class ChangelogStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :published

  transition from: :draft, to: [:published]
end
