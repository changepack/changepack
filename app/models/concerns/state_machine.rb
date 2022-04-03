# frozen_string_literal: true

module StateMachine
  extend ::ActiveSupport::Concern

  module Base
    extend ActiveSupport::Concern

    included do
      has_many transition_name, class_name: transition_class.to_s, autosave: false

      delegate :can_transition_to?,
               :current_state, :history, :last_transition, :last_transition_to,
               :transition_to!, :transition_to, :in_state?, to: :state_machine
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
  end

  module Settings
    extend ActiveSupport::Concern

    included do |base|
      @transition_class = "#{base.name}Transition".constantize
      @state_machine = "#{base.name}StateMachine".constantize
    end

    module ClassMethods
      def transition_name
        :transitions
      end

      def transition_class
        @transition_class
      end

      def state_machine
        @state_machine
      end
    end
  end

  included do |base|
    base.include Settings
    base.include Base
    base.include Statesman::Adapters::ActiveRecordQueries
  end
end
