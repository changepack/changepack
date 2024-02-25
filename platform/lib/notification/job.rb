# typed: false
# frozen_string_literal: true

class Notification
  class Job < ApplicationJob
    def perform(delivery_id)
      delivery = Notification::Delivery.find(delivery_id)

      process(delivery)
      mark_as_sent(delivery)
    end

    private

    def process(delivery)
      case delivery.channel
      when 'email'
        send_email(delivery)
      when 'slack'
        send_slack_notification(delivery)
      else
        raise "Unknown channel #{delivery.channel}"
      end
    end

    def mark_as_sent(delivery)
      delivery.sent_at = Time.current
      delivery.save!(validate: false)
    end

    def send_email(delivery)
      NotificationMailer.with(delivery:).notify.deliver_now
    end

    def send_slack_notification(delivery)
      hook = delivery.recipient
      notifier = Slack::Notifier.new(hook.request.webhook_url, **slack_opts(hook))
      notifier.ping(delivery.notification.body)
    end

    def slack_opts(hook)
      {
        channel: hook.request.channel,
        username: hook.request.username
      }
    end
  end
end
