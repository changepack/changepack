# typed: false
# frozen_string_literal: true

class Account < ApplicationRecord
  include ActiveModel::T

  include Slug

  PICTURES = %w[image/jpeg image/png image/gif].freeze

  key :acc

  attribute :name, :string
  attribute :description, :string
  attribute :website, :string

  has_many :users, dependent: :destroy
  has_many :changelogs, dependent: :destroy
  has_many :commits, dependent: :destroy
  has_many :repositories, dependent: :destroy

  has_one_attached :picture

  validates :website, url: true, allow_blank: true
  validates :picture, file_size: { less_than_or_equal_to: 1.megabyte },
                      file_content_type: { allow: PICTURES }

  normalize :name

  private

  sig { returns T::Symbol.array }
  def slug_candidates
    %i[name set_pretty_id]
  end
end
