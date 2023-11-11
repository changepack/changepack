# typed: false
# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def notify
    @delivery = params[:delivery]
    @notification = @delivery.notification

    mail(to: @delivery.user.email, subject: @notification.title)
  end
end
