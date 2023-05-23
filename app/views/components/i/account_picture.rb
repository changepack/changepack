# typed: false
# frozen_string_literal: true

module I
  class AccountPicture < ApplicationComponent
    DEFAULT = 'M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z' # rubocop:disable Layout/LineLength

    attribute :account, Account

    register_element :path

    def template
      span class: 'inline-block h-12 w-12 overflow-hidden rounded-full bg-gray-100 text-gray-300' do
        picture
      end
    end

    def picture
      if account.picture.present?
        helpers.image_tag(account.decorate.picture)
      else
        svg class: 'h-full w-full text-gray-300', fill: 'currentColor', viewBox: '0 0 24 24' do
          path d: DEFAULT
        end
      end
    end
  end
end
