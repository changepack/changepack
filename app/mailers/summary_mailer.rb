# typed: false
# frozen_string_literal: true

class SummaryMailer < ApplicationMailer
  def notify
    @post = params[:post]

    mail(to: @post.account.notifications, subject: @post.title)
  end
end
