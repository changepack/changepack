# frozen_string_literal: true

module Changepack
  module BoundedContext
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def subscribe(command, to:)
        commands[command] ||= []
        commands[command] << to
      end

      def commands
        @commands ||= {}
      end

      def setup(event_store)
        commands.each do |command, to|
          event_store.subscribe(command, to:)
        end
      end
    end
  end
end
