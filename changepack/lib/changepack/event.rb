# typed: false
# frozen_string_literal: true

require 'active_support/core_ext/hash'

module Changepack
  class Event < RailsEventStore::Event
    module Pubsub
      module ClassMethods
        delegate :publish, to: 'Rails.configuration.event_store'
      end

      def self.included(base)
        base.extend ClassMethods
      end
    end

    module Struct
      class Schema < Dry::Struct
        transform_keys(&:to_sym)
      end

      module ClassMethods
        extend Forwardable
        def_delegators :schema, :attribute, :attribute?

        def schema
          @schema ||= Class.new(Schema)
        end
      end

      module Constructor
        def initialize(event_id: SecureRandom.uuid, metadata: nil, data: {})
          super(event_id:, metadata:, data: data.deep_merge(self.class.schema.new(data.deep_symbolize_keys).to_h))
        end

        def data = Hashie::Mash.new(super)
      end

      def self.included(base)
        base.extend ClassMethods
        base.include Constructor
      end
    end

    include Struct
    include Pubsub
  end
end
