# frozen_string_literal: true

module Changepack
  class Command
    extend Dry::Initializer
    include AfterCommitEverywhere

    Error = Class.new(StandardError)

    module Params
      def self.prepended(base)
        class << base
          prepend ClassMethods
        end
      end

      module ClassMethods
        def option(name, type = nil, **opts, &)
          dry_initializer.option(name, type, **transform_types(opts), &)
          self
        end

        def transform_types(opts)
          opts.merge(type: opts[:optional] ? opts[:type]&.optional : opts[:type])
              .compact
        end
      end
    end

    module Transaction
      def perform(*args, **params)
        wrapper = proc { super }

        if self.class.transaction?
          ActiveRecord::Base.transaction(&wrapper)
        else
          wrapper.call
        end
      end

      def self.prepended(base)
        class << base
          prepend ClassMethods
        end
      end

      module ClassMethods
        def transaction=(value)
          @disable_transaction = !value
        end

        def transaction?
          @disable_transaction.blank?
        end
      end
    end

    module Validation
      def self.prepended(base)
        class << base
          prepend ClassMethods
        end
      end

      module ClassMethods
        def validate(&block)
          @validation = block
        end

        def validation
          @validation
        end
      end

      def valid?
        validate!
        true
      rescue Error
        false
      end

      def validate!
        self.class.validation.tap do |block|
          instance_exec(&block) if block.present?
        end
      end

      def perform(*args, **params)
        validate!
        super
      end
    end

    def self.inherited(subclass)
      super

      subclass.prepend Validation
      subclass.prepend Transaction
      subclass.prepend Params
    end
  end
end
