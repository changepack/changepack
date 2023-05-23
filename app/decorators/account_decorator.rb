# typed: false
# frozen_string_literal: true

class AccountDecorator < ApplicationDecorator
  SIZE = [48, 48].freeze

  sig { returns T.nilable(String) }
  def picture_url
    @picture_url ||= h.url_for(picture) if picture.present?
  end

  sig { returns T.any(ActiveStorage::Attached::One, ActiveStorage::VariantWithRecord) }
  def picture
    @picture ||= if super.blank?
                   super
                 else
                   super.variant(resize_to_fill: SIZE)
                 end
  end
end
