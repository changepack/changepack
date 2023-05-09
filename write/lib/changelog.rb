# typed: false
# frozen_string_literal: true

module T
  Changelog = T.type_alias { ::Changelog }
  Changelogs = T.type_alias { ::Changelog::RelationType }
end

class Changelog < ApplicationRecord
  include CustomDomain
  include Slug

  DEFAULT = 'Changelog'
  AUDIENCES = %w[non_technical technical internal].freeze

  key :cl

  attribute :name, :string
  attribute :custom_domain, :string
  attribute :audience, :string, default: :non_technical

  belongs_to :account
  has_many :posts, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :custom_domain, uniqueness: true, allow_nil: true
  validates :audience, presence: true, inclusion: { in: AUDIENCES }

  after_initialize do
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
