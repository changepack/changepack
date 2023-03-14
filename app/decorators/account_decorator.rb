# frozen_string_literal: true

class AccountDecorator < ApplicationDecorator
  DEFAULT_PICTURE = 'M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z' # rubocop:disable Layout/LineLength
  SIZE = [48, 48].freeze

  def display_picture
    return picture if picture.blank?

    picture.variant(resize_to_fill: SIZE)
  end

  def picture_tag
    if picture.blank?
      helpers.content_tag(:svg, class: 'h-full w-full text-gray-300', fill: 'currentColor', view_box: '0 0 24 24') do
        helpers.content_tag(:path, d: DEFAULT_PICTURE)
      end
    else
      helpers.image_tag(display_picture)
    end
  end
end
