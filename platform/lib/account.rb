# typed: false
# frozen_string_literal: true

class Account < ApplicationRecord
  include Slug

  key :acc

  attribute :name, :string
  attribute :website, :string
  attribute :description, :string

  has_one_attached :picture

  has_many :users, dependent: :destroy
  has_many :api_keys, as: :bearer, class_name: 'API::Key', dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :updates, dependent: :destroy
  has_many :newsletters, dependent: :destroy

  has_many :hooks, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :commits, dependent: :destroy
  has_many :repositories, dependent: :destroy
  has_many :access_tokens, dependent: :destroy

  PICTURES = %w[image/jpeg image/png image/gif].freeze

  validates :website, url: true, allow_blank: true
  validates :picture, file_size: { less_than_or_equal_to: 1.megabyte },
                      file_content_type: { allow: PICTURES }

  normalizes :name, with: ->(name) { name.squish }

  after_create do
    newsletters << Newsletter.new
    api_keys << API::Key.new
  end

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    %i[name set_pretty_id]
  end
end
