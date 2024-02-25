# typed: false
# frozen_string_literal: true

module Slack
  class Channel < ApplicationRecord
    key :slk

    attribute :name
    attribute :username
    attribute :webhook_url

    belongs_to :account

    validates :webhook_url, url: true
    validates :name, :username, :webhook_url, presence: true

    normalizes :name, with: ->(name) { name.squish.downcase }
    normalizes :username, with: ->(category) { category.squish }
  end
end
