# typed: false
# frozen_string_literal: true

class Newsletter < ApplicationRecord
  include Slug

  key :cl

  attribute :name, :string
  attribute :private, :boolean, default: true
  # A short description of the audience for this newsletter in natural language.
  # It is used to help AI write content with specific audiences and markets in mind.
  attribute :audience, :string, default: 'Company personnel'
  belongs_to :account

  has_many :posts, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :updates, dependent: :destroy

  before_validation do
    self.name ||= self.class.name
  end

  validates :name, presence: true
  normalizes :name, with: ->(name) { name.squish }

  scope :desc, -> { order(created_at: :desc) }

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    [
      %i[name set_slug_pretty_id]
    ]
  end
end
