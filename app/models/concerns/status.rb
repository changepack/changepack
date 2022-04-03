# frozen_string_literal: true

module Status
  extend ActiveSupport::Concern

  module Base
    extend ActiveSupport::Concern

    included do
      has_many transition_name, class_name: transition_class.to_s, autosave: false

      delegate :can_transition_to?, :history, :last_transition, :last_transition_to,
               :transition_to!, :transition_to, to: :state_machine
    end

    module ClassMethods
      def initial_state
        state_machine.initial_state
      end
    end

    def in_state?(state)
      current_state.to_sym == state.to_sym
    end

    def not_in_state?(state)
      current_state.to_sym != state.to_sym
    end

    def state_machine
      @state_machine ||= self.class.state_machine.new(
        self,
        transition_class: self.class.transition_class,
        association_name: self.class.transition_name
      )
    end

    def current_state
      self['status'].presence || state_machine.current_state
    end
  end

  module Settings
    extend ActiveSupport::Concern

    module ClassMethods
      attr_accessor :transition_class, :state_machine, :transition_name
    end

    included do |base|
      @transition_class = "#{base.name}Transition".constantize
      @state_machine = "#{base.name}StateMachine".constantize
      @transition_name = :transitions
    end
  end

  included do |base|
    base.include Settings
    base.include Base
    base.include Statesman::Adapters::ActiveRecordQueries[transition_class:, initial_state:, transition_name:]
  end
end
