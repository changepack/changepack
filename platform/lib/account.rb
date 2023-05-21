# typed: false
# frozen_string_literal: true

class Account < ApplicationRecord
  include Domain
  include Slug

  PICTURES = %w[image/jpeg image/png image/gif].freeze

  key :acc

  attribute :name, :string
  attribute :description, :string
  attribute :website, :string

  has_many :users, dependent: :destroy
  has_many :api_keys, as: :bearer, class_name: 'API::Key', dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :updates, dependent: :destroy
  has_many :changelogs, dependent: :destroy

  has_many :access_tokens, dependent: :destroy
  has_many :repositories, dependent: :destroy
  has_many :commits, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :issues, dependent: :destroy

  has_one_attached :picture

  validates :website, url: true, allow_blank: true
  validates :picture, file_size: { less_than_or_equal_to: 1.megabyte },
                      file_content_type: { allow: PICTURES }

  normalize :name

  after_create do
    changelogs << Changelog.new
    api_keys << API::Key.new
  end

  sig { returns T::Array[String] }
  def notifications
    @notifications ||= users.map(&:email)
  end

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    %i[name set_pretty_id]
  end
end
