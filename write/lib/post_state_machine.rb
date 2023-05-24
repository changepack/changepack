# typed: false
# frozen_string_literal: true

class PostStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :published

  transition from: :draft, to: [:published]
  transition from: :published, to: [:draft]

  after_transition after_commit: true do |post, transition|
    post.update!(status: transition.to_state)
  end

  before_transition to: :published do |post, _|
    post.update!(published_at: Time.current)
  end

  after_transition to: :draft, after_commit: true do |post, _|
    post.update!(published_at: nil)
  end
end
