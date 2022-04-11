# frozen_string_literal: true

class Account < ApplicationRecord
  extend FriendlyId

  key :acc

  attribute :name, :string

  has_many :users, dependent: :destroy
  has_many :changelogs, dependent: :destroy

  normalize :name
  friendly_id :slug_candidates

  private

  def slug_candidates
    %i[name set_pretty_id]
  end
end
