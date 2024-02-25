# typed: false
# frozen_string_literal: true

class Hook
  module Slack
    class Request < Base
      include ValueObject

      attribute :channel, :string
      attribute :username, :string
      attribute :webhook_url, :string

      validates :webhook_url, url: true
      validates :channel, :username, :webhook_url, presence: true

      normalizes :channel, with: ->(name) { name.squish.downcase }
      normalizes :username, with: ->(category) { category.squish }
    end
  end
end
