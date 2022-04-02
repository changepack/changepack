class ChangelogStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :published

  transition from: :draft, to: [:published]

  after_transition(to: :published) do |changelog, _|
    changelog.update!(status: 'published')
  end
end
