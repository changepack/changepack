# frozen_string_literal: true

module Changepack
  class EventHandler < ActiveJob::Base # rubocop:disable Rails/ApplicationJob
    Error = Class.new(StandardError)
    NotImplemented = Class.new(Error)

    def self.subscribe(event)
      Rails.configuration.event_store.subscribe(self, to: [event])
    end

    def perform(payload)
      klass = payload.fetch(:event_type).constantize
      opts = payload.slice(:data, :event_id, :metadata)

      @payload = payload
      @event = klass.new(**opts)

      call
    end

    def call
      raise NotImplemented
    end

    private

    attr_reader :event, :payload
  end
end
