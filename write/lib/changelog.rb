# typed: false
# frozen_string_literal: true

module T
  Changelog = T.type_alias { ::Changelog }
  Changelogs = T.type_alias { ::Changelog::RelationType }
end

class Changelog < ApplicationRecord
  include Domain
  include Slug

  DEFAULT = 'Changelog'
  AUDIENCES = %w[technical general in_house].freeze

  key :cl

  attribute :name, :string
  attribute :domain, :string
  attribute :audience, :string, default: :general

  belongs_to :account
  has_many :posts, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :domain, uniqueness: true, allow_nil: true
  validates :audience, presence: true, inclusion: { in: AUDIENCES }

  before_validation do
    self.name ||= DEFAULT
  end

  private

  sig { returns T::Array[Symbol] }
  def slug_candidates
    [
      %i[name set_slug_pretty_id]
    ]
  end
end
