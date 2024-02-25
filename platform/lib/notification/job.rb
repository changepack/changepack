# typed: false
# frozen_string_literal: true

class Notification
  class Job < ApplicationJob
    def perform(delivery_id)
      delivery = Notification::Delivery.find(delivery_id)
      case delivery.channel
      when 'email'
        NotificationMailer.with(delivery:).notify.deliver_now
      else
        raise "Unknown channel #{delivery.channel}"
      end

      delivery.sent_at = Time.current
      delivery.save!(validate: false)
    end
  end
end
