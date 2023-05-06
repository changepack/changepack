# typed: false
# frozen_string_literal: true

module Status
  extend ActiveSupport::Concern
  extend T::Helpers

  abstract!

  module Base
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      has_many transition_name, class_name: transition_class.to_s, autosave: false, dependent: :delete_all

      delegate :can_transition_to?, :history, :last_transition, :last_transition_to,
               :transition_to!, :transition_to, to: :state_machine

      validates :status, presence: true, inclusion: { in: state_machine.states }
    end

    class_methods do
      delegate :initial_state, to: :state_machine
    end

    sig { overridable.params(state: T::Key).returns(T::Boolean) }
    def in_state?(state)
      current_state.to_sym == state.to_sym
    end

    sig { overridable.params(state: T::Key).returns(T::Boolean) }
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

    sig { overridable.returns String }
    def current_state
      self['status'].presence || state_machine.current_state
    end
  end

  module Settings
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    module ClassMethods
      attr_accessor :transition_class, :state_machine, :transition_name
    end

    included do |base|
      @transition_class = "#{base.name}Transition".constantize # rubocop:disable Sorbet/ConstantsFromStrings
      @state_machine = "#{base.name}StateMachine".constantize # rubocop:disable Sorbet/ConstantsFromStrings
      @transition_name = :transitions
    end
  end

  included do |base|
    base.include Settings
    base.include Base
    base.include Statesman::Adapters::ActiveRecordQueries[transition_class:, initial_state:, transition_name:]
  end
end
