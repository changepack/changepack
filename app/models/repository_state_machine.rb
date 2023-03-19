# typed: false
# frozen_string_literal: true

class RepositoryStateMachine
  include Statesman::Machine

  state :inactive, initial: true
  state :active

  transition from: :inactive, to: [:active]
  transition from: :active, to: [:inactive]

  after_transition(after_commit: true) do |repository, transition|
    repository.update!(status: transition.to_state)
  end

  after_transition(to: :active, after_commit: true) do |repository, _|
    Event.publish(
      Repository::Outdated.new(repository_id: repository.id)
    )
  end
end
