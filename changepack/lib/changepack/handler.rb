# typed: false
# frozen_string_literal: true

module Changepack
  class Handler < ActiveJob::Base # rubocop:disable Rails/ApplicationJob
    extend T::Helpers
    extend T::Sig

    abstract!

    sig { params(event: T.class_of(Changepack::Event)).void }
    def self.on(event)
      Rails.configuration.event_store.subscribe(self, to: [event])
    end

    sig { params(payload: T::Hash[T::Symbol | T::String, T.untyped]).returns(T.untyped) }
    def perform(payload)
      @payload = payload.deep_symbolize_keys

      klass = @payload.fetch(:event_type).constantize # rubocop:disable Sorbet/ConstantsFromStrings
      opts = @payload.slice(:data, :event_id, :metadata)

      @event = klass.new(**opts[:data], **opts)

      run
    end

    sig { abstract.returns T.untyped }
    def run; end

    private

    attr_reader :event, :payload
  end
end
