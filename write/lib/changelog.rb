# typed: false
# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Slug

  DEFAULT = 'Changelog'
  PRIVACY = %w[public unlisted].freeze
  AUDIENCES = %w[mainstream tech in_house].freeze

  key :cl

  attribute :name, :string
  attribute :privacy, :string, default: :public
  attribute :audience, :string, default: :mainstream
  # A short description of the audience for this changelog in natural language.
  # It is used to help AI write content with specific audiences and markets in mind.
  attribute :about_audience, :string

  belongs_to :account
  has_many :posts, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :updates, dependent: :destroy

  before_validation do
    self.name ||= DEFAULT
  end

  validates :name, presence: true
  validates :audience, presence: true, inclusion: { in: AUDIENCES }
  validates :privacy, presence: true, inclusion: { in: PRIVACY }

  normalize :name, :about_audience
  normalize :about_audience, with: :presence

  inquirer :audience
  inquirer :privacy

  scope :desc, -> { order(created_at: :desc) }

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    [
      %i[name set_slug_pretty_id]
    ]
  end
end
