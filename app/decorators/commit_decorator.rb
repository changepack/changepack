# frozen_string_literal: true

class CommitDecorator < ApplicationDecorator
  delegate_all

  def message
    object.message.truncate(50)
  end
end
