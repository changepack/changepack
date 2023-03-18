# typed: false
# frozen_string_literal: true

module Changepack
  class Handler < ActiveJob::Base # rubocop:disable Rails/ApplicationJob
    def self.on(event)
      Rails.configuration.event_store.subscribe(self, to: [event])
    end

    def perform(payload)
      @payload = payload.deep_symbolize_keys

      klass = @payload.fetch(:event_type).constantize # rubocop:disable Sorbet/ConstantsFromStrings
      opts = @payload.slice(:data, :event_id, :metadata)

      @event = klass.new(**opts)

      run
    end

    def run
      raise NoMethodError
    end

    private

    attr_reader :event, :payload
  end
end
