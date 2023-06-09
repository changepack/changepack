# typed: false
# frozen_string_literal: true

module API
  class Image < ApplicationRecord
    key :img
    has_one_attached :file
  end
end
