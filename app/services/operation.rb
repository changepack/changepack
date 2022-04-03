# typed: false
# frozen_string_literal: true

class Operation
  extend Dry::Initializer
  include AfterCommitEverywhere

  module Params
    def self.prepended(base)
      class << base
        prepend ClassMethods
      end
    end

    module ClassMethods
      def params(attrs)
        param :params, type: lambda { |params|
          Types::Hash.schema(attrs)
                     .with_key_transform(&:to_sym)
                     .then { |schema| schema[params.to_h] }
                     .then { |schema| Hashie::Mash.new(schema) }
        }
      end
    end
  end

  module Transaction
    def perform(*args, **params)
      wrapper = proc { args.present? || params.present? ? super : super() }

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

  def self.inherited(subclass)
    super

    subclass.prepend Params
    subclass.prepend Transaction
  end
end
