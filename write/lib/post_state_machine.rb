# typed: false
# frozen_string_literal: true

class PostStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :published

  transition from: :draft, to: [:published]
  transition from: :published, to: [:draft]

  before_transition to: :published do |post, _|
    post.update!(published_at: Time.current)
  end

  after_transition do |post, transition|
    post.update!(status: transition.to_state)
  end

  after_transition to: :published, after_commit: true do |post, transition|
    Event.publish(
      Post::Published.new(
        id: transition.post_id,
        content: post.content.to_s,
        account_id: post.account_id
      )
    )
  end

  after_transition to: :draft do |post, _|
    post.update!(published_at: nil)
  end
end
