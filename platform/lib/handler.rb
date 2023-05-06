# typed: false
# frozen_string_literal: true

class Handler < ActiveJob::Base # rubocop:disable Rails/ApplicationJob
  extend T::Helpers
  extend T::Sig

  attr_reader :event, :payload

  abstract!

  sig { params(event: T.class_of(Event)).void }
  def self.on(event)
    Rails.configuration.event_store.subscribe(self, to: [event])
  end

  sig { params(payload: T::Payload).returns(T::Boolean) }
  def perform(payload)
    @payload = payload.deep_symbolize_keys

    klass = @payload.fetch(:event_type).constantize # rubocop:disable Sorbet/ConstantsFromStrings
    opts = @payload.slice(:data, :event_id, :metadata)

    @event = klass.new(**opts[:data], **opts)

    run

    true
  end

  sig { abstract.returns T.untyped }
  def run; end
end
