# typed: false
# frozen_string_literal: true

module Changepack
  class Event < T::InexactStruct
    extend T::Sig
    extend T::Helpers
    extend ActiveSupport::Concern

    Key = T.type_alias { T::String | T::Symbol }

    sig { params(event: T.untyped).returns(String) }
    def self.publish(event)
      Rails.configuration.event_store.publish(event)

      event.event_id
    end

    sig { params(name: Symbol, type: T.untyped).void }
    def self.attribute(name, type)
      raise ArgumentError, "#{name} is a reserved attribute name" if name.in?(%i[event_id metadata data])

      # Nilable consts needed to maintain compatibility with `RailsEventStore`.
      # Consistency with `ActiveRecord::Attributes` is a nice bonus.
      const name, T.nilable(type)
    end

    prop :event_id, T.nilable(String), factory: -> { SecureRandom.uuid }
    prop :metadata, T.nilable(T::Hash[Key, T.untyped]), default: {}
    prop :data, T.nilable(T::Hash[Key, T.untyped])

    sig { returns T::Hash[Key, T.untyped] }
    def data
      @data&.as_json || serialize.except('event_id', 'metadata', 'data')
    end

    sig { returns String }
    def message_id
      event_id
    end

    sig { returns String }
    def event_type
      metadata[:event_type] || self.class.name
    end

    sig { returns T::Time.nilable }
    def timestamp
      metadata[:timestamp] || Time.current
    end

    sig { returns T::Time.nilable }
    def valid_at
      metadata[:valid_at]
    end

    sig { params(other: T.untyped).returns(T::Boolean) }
    def ==(other)
      other.instance_of?(self.class) && other.event_type.eql?(event_type) &&
        other.event_id.eql?(event_id) && other.data.eql?(data)
    end

    sig { returns Integer }
    def hash
      # We don't use metadata because == does not use metadata
      [
        [event_type, event_id, data],
        self.class
      ].hash
    end

    sig { returns T::String.nilable }
    def correlation_id
      metadata[:correlation_id]
    end

    sig { params(val: String).returns(String) }
    def correlation_id=(val)
      metadata[:correlation_id] = val
    end

    sig { returns T::String.nilable }
    def causation_id
      metadata[:causation_id]
    end

    sig { params(val: String).returns(String) }
    def causation_id=(val)
      metadata[:causation_id] = val
    end

    sig { params(other_message: T::Struct).returns(String) }
    def correlate_with(other_message)
      self.correlation_id = other_message.correlation_id || other_message.message_id
      self.causation_id = other_message.message_id
      self
    end

    alias eql? ==
  end
end
