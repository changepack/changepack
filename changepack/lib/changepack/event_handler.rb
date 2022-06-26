# frozen_string_literal: true

module Changepack
  class EventHandler < ActiveJob::Base # rubocop:disable Rails/ApplicationJob
    NotImplemented = Class.new(StandardError)

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
