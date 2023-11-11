# typed: false
# frozen_string_literal: true

class NotificationPreview < ActionMailer::Preview
  def notify
    NotificationMailer.with(delivery: Notification::Delivery.first).notify
  end
end
