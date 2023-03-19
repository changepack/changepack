# typed: false
# frozen_string_literal: true

class AccountDecorator < ApplicationDecorator
  SIZE = [48, 48].freeze

  sig { returns T.nilable(ActiveStorage::VariantWithRecord) }
  def thumb
    return picture if picture.blank?

    @thumb ||= picture.variant(resize_to_fill: SIZE)
  end
end
