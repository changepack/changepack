# typed: false
# frozen_string_literal: true

class SummaryPreview < ActionMailer::Preview
  def notify
    SummaryMailer.with(post: Post.first).notify
  end
end
