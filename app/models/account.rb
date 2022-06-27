# frozen_string_literal: true

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

  def slug_candidates
    %i[name set_pretty_id]
  end
end
