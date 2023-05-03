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

  key :cl

  attribute :name, :string

  belongs_to :account
  has_many :posts, dependent: :destroy
  has_many :access_tokens, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true

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
