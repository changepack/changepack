# typed: false
# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def notify
    @delivery = params[:delivery]
    @notification = @delivery.notification

    mail(to: @delivery.recipient.email, subject: @notification.title)
  end
end
