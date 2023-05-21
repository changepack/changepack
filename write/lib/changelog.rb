# typed: false
# frozen_string_literal: true

module T
  Changelogs = T.type_alias { ::Changelog::RelationType }
end

class Changelog < ApplicationRecord
  include Slug

  DEFAULT = 'Changelog'
  PRIVACY = %w[public unlisted].freeze
  AUDIENCES = %w[mainstream tech in_house].freeze

  key :cl

  attribute :name, :string
  attribute :privacy, :string, default: :public
  attribute :audience, :string, default: :mainstream

  belongs_to :account
  has_many :posts, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :audience, presence: true, inclusion: { in: AUDIENCES }
  validates :privacy, presence: true, inclusion: { in: PRIVACY }

  inquirer :audience
  inquirer :privacy

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
