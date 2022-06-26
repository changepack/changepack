# frozen_string_literal: true

module Changepack
  class EventHandler < ActiveJob::Base # rubocop:disable Rails/ApplicationJob
    Error = Class.new(StandardError)
    NotImplemented = Class.new(Error)

    def self.subscribe(event)
      Rails.configuration.event_store.subscribe(self, to: [event])
    end

    def perform(payload)
      @payload = payload
      @event = payload[:event_type].constantize.new(payload[:data])

      call
    end

    def call
      raise NotImplemented
    end

    private

    attr_reader :event, :payload
  end
end
