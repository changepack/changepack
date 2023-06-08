# typed: false
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('APP_EMAIL')
  layout 'mailer'
end
