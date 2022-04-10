# frozen_string_literal: true

class Event < Dry::Struct
  class << self
    delegate :publish, to: 'Rails.configuration.event_store'
  end

  transform_keys(&:to_sym)

  attribute :event_id, Types::EventId
  attribute :metadata, Types::Metadata
  alias message_id event_id

  def self.inherited(klass)
    super
    klass.define_singleton_method(:event_type) do |value|
      klass.define_method(:event_type) do
        value
      end
    end
  end

  def timestamp
    metadata[:timestamp]
  end

  def valid_at
    metadata[:valid_at]
  end

  def data
    to_h.reject { |k, _| ignore.include?(k) }
  end

  def event_type
    self.class.name
  end

  def ==(other)
    other.instance_of?(self.class) &&
      other.event_id.eql?(event_id) &&
      other.data.eql?(data)
  end

  alias eql? ==

  private

  def ignore
    %i[event_id metadata]
  end
end
