# frozen_string_literal: true
# typed: strict

class Account < ApplicationRecord
  include Slug

  key :acc

  attribute :name, :string
  attribute :discarded, :datetime

  has_many :users, dependent: :destroy
  has_many :changelogs, dependent: :destroy
  has_many :commits, dependent: :destroy

  normalize :name

  private

  sig { returns(T::Array[Symbol]) }
  def slug_candidates
    %i[name set_pretty_id]
  end
end
