# frozen_string_literal: true

class AccountDecorator < ApplicationDecorator
  SIZE = [48, 48].freeze

  def thumb
    return picture if picture.blank?

    @thumb ||= picture.variant(resize_to_fill: SIZE)
  end
end
