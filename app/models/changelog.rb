# frozen_string_literal: true

class Changelog < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: ChangelogTransition,
    initial_state: ChangelogStateMachine.initial_state,
    transition_name: :transitions
  ]

  key :log

  attribute :title, :string

  has_rich_text :content
  has_many :transitions, class_name: 'ChangelogTransition', autosave: false

  validates :content, presence: true

  delegate :can_transition_to?,
           :current_state, :history, :last_transition, :last_transition_to,
           :transition_to!, :transition_to, :in_state?, to: :state_machine

  def state_machine
    @state_machine ||= ChangelogStateMachine.new(self, transition_class: ChangelogTransition, association_name: :transitions)
  end
end
