# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `statesman` gem.
# Please instead update this file by running `bin/tapioca gem statesman`.

# Add statesman attributes to a pre-existing transition class
#
# source://statesman//lib/statesman.rb#3
module Statesman
  class << self
    # source://statesman//lib/statesman.rb#41
    def config; end

    # Example:
    #   Statesman.configure do
    #     storage_adapter Statesman::ActiveRecordAdapter
    #     enable_mysql_gaplock_protection
    #   end
    #
    # source://statesman//lib/statesman.rb#26
    def configure(&block); end

    # @return [Boolean]
    #
    # source://statesman//lib/statesman.rb#35
    def mysql_gaplock_protection?; end

    # source://statesman//lib/statesman.rb#31
    def storage_adapter; end
  end
end

# source://statesman//lib/statesman.rb#10
module Statesman::Adapters; end

# source://statesman//lib/statesman/adapters/active_record.rb#7
class Statesman::Adapters::ActiveRecord
  # @return [ActiveRecord] a new instance of ActiveRecord
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#23
  def initialize(transition_class, parent_model, observer, options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record.rb#42
  def create(from, to, metadata = T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record.rb#58
  def history(force_reload: T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record.rb#69
  def last(force_reload: T.unsafe(nil)); end

  # Returns the value of attribute parent_model.
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#40
  def parent_model; end

  # source://statesman//lib/statesman/adapters/active_record.rb#78
  def reset; end

  # Returns the value of attribute transition_class.
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#40
  def transition_class; end

  # Returns the value of attribute transition_table.
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#40
  def transition_table; end

  private

  # source://statesman//lib/statesman/adapters/active_record.rb#132
  def add_after_commit_callback(from, to, transition); end

  # source://statesman//lib/statesman/adapters/active_record.rb#276
  def association_join_primary_key(association); end

  # Provide a wrapper for constructing an update manager which handles a breaking API
  # change in Arel as we move into Rails >6.0.
  #
  # https://github.com/rails/rails/commit/7508284800f67b4611c767bff9eae7045674b66f
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#225
  def build_arel_manager(manager); end

  # Generates update_all Arel values that will touch the updated timestamp (if valid
  # for this model) and set most_recent to true only for the transition with a
  # matching most_recent ID.
  #
  # This is quite nasty, but combines two updates (set all most_recent = f, set
  # current most_recent = t) into one, which helps improve transition performance
  # especially when database latency is significant.
  #
  # The SQL this can help produce looks like:
  #
  #   update transitions
  #      set most_recent = (case when id = 'PA123' then TRUE else FALSE end)
  #        , updated_at = '...'
  #      ...
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#191
  def build_most_recents_update_all_values(most_recent_id = T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record.rb#85
  def create_transition(from, to, metadata); end

  # source://statesman//lib/statesman/adapters/active_record.rb#329
  def db_false; end

  # source://statesman//lib/statesman/adapters/active_record.rb#333
  def db_null; end

  # source://statesman//lib/statesman/adapters/active_record.rb#325
  def db_true; end

  # source://statesman//lib/statesman/adapters/active_record.rb#311
  def default_timezone; end

  # source://statesman//lib/statesman/adapters/active_record.rb#123
  def default_transition_attributes(to, metadata); end

  # source://statesman//lib/statesman/adapters/active_record.rb#160
  def most_recent_transitions(most_recent_id = T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record.rb#211
  def most_recent_value(most_recent_id); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#321
  def mysql_gaplock_protection?; end

  # source://statesman//lib/statesman/adapters/active_record.rb#233
  def next_sort_key; end

  # Check whether the `most_recent` column allows null values. If it doesn't, set old
  # records to `false`, otherwise, set them to `NULL`.
  #
  # Some conditioning here is required to support databases that don't support partial
  # indexes. By doing the conditioning on the column, rather than Rails' opinion of
  # whether the database supports partial indexes, we're robust to DBs later adding
  # support for partial indexes.
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#350
  def not_most_recent_value(db_cast: T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record.rb#267
  def parent_join_foreign_key; end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#237
  def serialized?(transition_class); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#247
  def transition_conflict_error?(err); end

  # source://statesman//lib/statesman/adapters/active_record.rb#140
  def transitions_for_parent; end

  # source://statesman//lib/statesman/adapters/active_record.rb#172
  def transitions_of_parent; end

  # Type casting against a column is deprecated and will be removed in Rails 6.2.
  # See https://github.com/rails/arel/commit/6160bfbda1d1781c3b08a33ec4955f170e95be11
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#339
  def type_cast(value); end

  # source://statesman//lib/statesman/adapters/active_record.rb#254
  def unique_indexes; end

  # Sets the given transition most_recent = t while unsetting the most_recent of any
  # previous transitions.
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#146
  def update_most_recents(most_recent_id = T.unsafe(nil)); end

  # updated_column_and_timestamp should return [column_name, value]
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#289
  def updated_column_and_timestamp; end

  class << self
    # source://statesman//lib/statesman/adapters/active_record.rb#19
    def adapter_name; end

    # @return [Boolean]
    #
    # source://statesman//lib/statesman/adapters/active_record.rb#10
    def database_supports_partial_indexes?; end
  end
end

# source://statesman//lib/statesman/adapters/active_record.rb#8
Statesman::Adapters::ActiveRecord::JSON_COLUMN_TYPES = T.let(T.unsafe(nil), Array)

# source://statesman//lib/statesman/adapters/active_record.rb#359
class Statesman::Adapters::ActiveRecordAfterCommitWrap
  # @return [ActiveRecordAfterCommitWrap] a new instance of ActiveRecordAfterCommitWrap
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#360
  def initialize(&block); end

  # Required for +transaction(requires_new: true)+
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#388
  def add_to_transaction(*_arg0); end

  # source://statesman//lib/statesman/adapters/active_record.rb#383
  def before_committed!(*_arg0); end

  # source://statesman//lib/statesman/adapters/active_record.rb#379
  def committed!(*_arg0); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#374
  def has_transactional_callbacks?; end

  # source://statesman//lib/statesman/adapters/active_record.rb#385
  def rolledback!(*_arg0); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/adapters/active_record.rb#369
  def trigger_transactional_callbacks?; end

  class << self
    # @return [Boolean]
    #
    # source://statesman//lib/statesman/adapters/active_record.rb#365
    def trigger_transactional_callbacks?; end
  end
end

# source://statesman//lib/statesman/adapters/active_record_queries.rb#5
module Statesman::Adapters::ActiveRecordQueries
  class << self
    # source://statesman//lib/statesman/adapters/active_record_queries.rb#32
    def [](**args); end

    # @raise [NotImplementedError]
    #
    # source://statesman//lib/statesman/adapters/active_record_queries.rb#6
    def check_missing_methods!(base); end

    # @private
    #
    # source://statesman//lib/statesman/adapters/active_record_queries.rb#19
    def included(base); end
  end
end

# source://statesman//lib/statesman/adapters/active_record_queries.rb#36
class Statesman::Adapters::ActiveRecordQueries::ClassMethods < ::Module
  # @return [ClassMethods] a new instance of ClassMethods
  #
  # source://statesman//lib/statesman/adapters/active_record_queries.rb#37
  def initialize(**args); end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#41
  def included(base); end

  private

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#65
  def define_in_state(base, query_builder); end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#74
  def define_not_in_state(base, query_builder); end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#56
  def ensure_inheritance(base); end
end

# source://statesman//lib/statesman/adapters/active_record_queries.rb#84
class Statesman::Adapters::ActiveRecordQueries::QueryBuilder
  # @return [QueryBuilder] a new instance of QueryBuilder
  #
  # source://statesman//lib/statesman/adapters/active_record_queries.rb#85
  def initialize(model, transition_class:, initial_state:, most_recent_transition_alias: T.unsafe(nil), transition_name: T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#105
  def most_recent_transition_join; end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#95
  def states_where(states); end

  private

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#147
  def db_true; end

  # Returns the value of attribute initial_state.
  #
  # source://statesman//lib/statesman/adapters/active_record_queries.rb#114
  def initial_state; end

  # Returns the value of attribute model.
  #
  # source://statesman//lib/statesman/adapters/active_record_queries.rb#114
  def model; end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#134
  def model_foreign_key; end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#130
  def model_primary_key; end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#138
  def model_table; end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#142
  def most_recent_transition_alias; end

  # Returns the value of attribute transition_class.
  #
  # source://statesman//lib/statesman/adapters/active_record_queries.rb#114
  def transition_class; end

  # source://statesman//lib/statesman/adapters/active_record_queries.rb#116
  def transition_name; end

  # @raise [MissingTransitionAssociation]
  #
  # source://statesman//lib/statesman/adapters/active_record_queries.rb#120
  def transition_reflection; end
end

# source://statesman//lib/statesman/adapters/active_record_transition.rb#7
module Statesman::Adapters::ActiveRecordTransition
  extend ::ActiveSupport::Concern
  include GeneratedInstanceMethods

  mixes_in_class_methods GeneratedClassMethods

  module GeneratedClassMethods
    def updated_timestamp_column; end
    def updated_timestamp_column=(value); end
    def updated_timestamp_column?; end
  end

  module GeneratedInstanceMethods
    def updated_timestamp_column; end
    def updated_timestamp_column=(value); end
    def updated_timestamp_column?; end
  end
end

# source://statesman//lib/statesman/adapters/active_record_transition.rb#8
Statesman::Adapters::ActiveRecordTransition::DEFAULT_UPDATED_TIMESTAMP_COLUMN = T.let(T.unsafe(nil), Symbol)

# source://statesman//lib/statesman/adapters/memory.rb#7
class Statesman::Adapters::Memory
  # We only accept mode as a parameter to maintain a consistent interface
  # with other adapters which require it.
  #
  # @return [Memory] a new instance of Memory
  #
  # source://statesman//lib/statesman/adapters/memory.rb#13
  def initialize(transition_class, parent_model, observer, _opts = T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/memory.rb#20
  def create(from, to, metadata = T.unsafe(nil)); end

  # source://statesman//lib/statesman/adapters/memory.rb#36
  def history(*_arg0); end

  # source://statesman//lib/statesman/adapters/memory.rb#32
  def last(*_arg0); end

  # Returns the value of attribute parent_model.
  #
  # source://statesman//lib/statesman/adapters/memory.rb#9
  def parent_model; end

  # source://statesman//lib/statesman/adapters/memory.rb#40
  def reset; end

  # Returns the value of attribute transition_class.
  #
  # source://statesman//lib/statesman/adapters/memory.rb#8
  def transition_class; end

  private

  # source://statesman//lib/statesman/adapters/memory.rb#46
  def next_sort_key; end
end

# source://statesman//lib/statesman/adapters/memory_transition.rb#5
class Statesman::Adapters::MemoryTransition
  # @return [MemoryTransition] a new instance of MemoryTransition
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#12
  def initialize(to, sort_key, metadata = T.unsafe(nil)); end

  # Returns the value of attribute created_at.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#6
  def created_at; end

  # Sets the attribute created_at
  #
  # @param value the value to set the attribute created_at to.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#6
  def created_at=(_arg0); end

  # Returns the value of attribute metadata.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#10
  def metadata; end

  # Sets the attribute metadata
  #
  # @param value the value to set the attribute metadata to.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#10
  def metadata=(_arg0); end

  # Returns the value of attribute sort_key.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#9
  def sort_key; end

  # Sets the attribute sort_key
  #
  # @param value the value to set the attribute sort_key to.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#9
  def sort_key=(_arg0); end

  # Returns the value of attribute to_state.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#8
  def to_state; end

  # Sets the attribute to_state
  #
  # @param value the value to set the attribute to_state to.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#8
  def to_state=(_arg0); end

  # Returns the value of attribute updated_at.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#7
  def updated_at; end

  # Sets the attribute updated_at
  #
  # @param value the value to set the attribute updated_at to.
  #
  # source://statesman//lib/statesman/adapters/memory_transition.rb#7
  def updated_at=(_arg0); end
end

# source://statesman//lib/statesman/callback.rb#6
class Statesman::Callback
  # @return [Callback] a new instance of Callback
  #
  # source://statesman//lib/statesman/callback.rb#11
  def initialize(options = T.unsafe(nil)); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/callback.rb#25
  def applies_to?(options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/callback.rb#21
  def call(*args); end

  # Returns the value of attribute callback.
  #
  # source://statesman//lib/statesman/callback.rb#9
  def callback; end

  # Returns the value of attribute from.
  #
  # source://statesman//lib/statesman/callback.rb#7
  def from; end

  # Returns the value of attribute to.
  #
  # source://statesman//lib/statesman/callback.rb#8
  def to; end

  private

  # source://statesman//lib/statesman/callback.rb#31
  def matches(from, to); end

  # source://statesman//lib/statesman/callback.rb#38
  def matches_all_transitions; end

  # source://statesman//lib/statesman/callback.rb#50
  def matches_both_states(from, to); end

  # source://statesman//lib/statesman/callback.rb#42
  def matches_from_state(from, to); end

  # source://statesman//lib/statesman/callback.rb#46
  def matches_to_state(from, to); end
end

# source://statesman//lib/statesman/config.rb#7
class Statesman::Config
  # @return [Config] a new instance of Config
  #
  # source://statesman//lib/statesman/config.rb#10
  def initialize(block = T.unsafe(nil)); end

  # Returns the value of attribute adapter_class.
  #
  # source://statesman//lib/statesman/config.rb#8
  def adapter_class; end

  # source://statesman//lib/statesman/config.rb#27
  def enable_mysql_gaplock_protection; end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/config.rb#18
  def mysql_gaplock_protection?; end

  # source://statesman//lib/statesman/config.rb#14
  def storage_adapter(adapter_class); end

  private

  # source://statesman//lib/statesman/config.rb#40
  def adapter_name(adapter_class); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/config.rb#33
  def mysql_adapter?(adapter_class); end
end

# source://statesman//lib/statesman/guard.rb#7
class Statesman::Guard < ::Statesman::Callback
  # @raise [GuardFailedError]
  #
  # source://statesman//lib/statesman/guard.rb#8
  def call(*args); end
end

# source://statesman//lib/statesman/exceptions.rb#30
class Statesman::GuardFailedError < ::StandardError
  # @return [GuardFailedError] a new instance of GuardFailedError
  #
  # source://statesman//lib/statesman/exceptions.rb#31
  def initialize(from, to); end

  # Returns the value of attribute from.
  #
  # source://statesman//lib/statesman/exceptions.rb#37
  def from; end

  # Returns the value of attribute to.
  #
  # source://statesman//lib/statesman/exceptions.rb#37
  def to; end

  private

  # source://statesman//lib/statesman/exceptions.rb#41
  def _message; end
end

# source://statesman//lib/statesman/exceptions.rb#60
class Statesman::IncompatibleSerializationError < ::StandardError
  # @return [IncompatibleSerializationError] a new instance of IncompatibleSerializationError
  #
  # source://statesman//lib/statesman/exceptions.rb#61
  def initialize(transition_class_name); end

  private

  # source://statesman//lib/statesman/exceptions.rb#67
  def _message(transition_class_name); end
end

# source://statesman//lib/statesman/exceptions.rb#8
class Statesman::InvalidCallbackError < ::StandardError; end

# source://statesman//lib/statesman/exceptions.rb#4
class Statesman::InvalidStateError < ::StandardError; end

# source://statesman//lib/statesman/exceptions.rb#6
class Statesman::InvalidTransitionError < ::StandardError; end

# The main module, that should be `extend`ed in to state machine classes.
#
# source://statesman//lib/statesman/machine.rb#11
module Statesman::Machine
  mixes_in_class_methods ::Statesman::Machine::ClassMethods

  # source://statesman//lib/statesman/machine.rb#233
  def initialize(object, options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#254
  def allowed_transitions(metadata = T.unsafe(nil)); end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/machine.rb#268
  def can_transition_to?(new_state, metadata = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#245
  def current_state(force_reload: T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#305
  def execute(phase, initial_state, new_state, transition); end

  # source://statesman//lib/statesman/machine.rb#300
  def execute_on_failure(phase, initial_state, new_state, exception); end

  # source://statesman//lib/statesman/machine.rb#277
  def history; end

  # @return [Boolean]
  #
  # source://statesman//lib/statesman/machine.rb#250
  def in_state?(*states); end

  # source://statesman//lib/statesman/machine.rb#260
  def last_transition(force_reload: T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#264
  def last_transition_to(state); end

  # source://statesman//lib/statesman/machine.rb#316
  def reset; end

  # source://statesman//lib/statesman/machine.rb#310
  def transition_to(new_state, metadata = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#281
  def transition_to!(new_state, metadata = T.unsafe(nil)); end

  private

  # source://statesman//lib/statesman/machine.rb#322
  def adapter_class(transition_class); end

  # source://statesman//lib/statesman/machine.rb#338
  def callbacks_for(phase, options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#334
  def guards_for(options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#342
  def select_callbacks_for(callbacks, options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#330
  def successors_for(from); end

  # source://statesman//lib/statesman/machine.rb#361
  def to_s_or_nil(input); end

  # @raise [TransitionFailedError]
  #
  # source://statesman//lib/statesman/machine.rb#348
  def validate_transition(options = T.unsafe(nil)); end

  class << self
    # @private
    #
    # source://statesman//lib/statesman/machine.rb#12
    def included(base); end

    # Retry any transitions that fail due to a TransitionConflictError
    #
    # source://statesman//lib/statesman/machine.rb#18
    def retry_conflicts(max_retries = T.unsafe(nil)); end
  end
end

# source://statesman//lib/statesman/machine.rb#29
module Statesman::Machine::ClassMethods
  # source://statesman//lib/statesman/machine.rb#120
  def after_guard_failure(options = T.unsafe(nil), &block); end

  # source://statesman//lib/statesman/machine.rb#108
  def after_transition(options = T.unsafe(nil), &block); end

  # source://statesman//lib/statesman/machine.rb#115
  def after_transition_failure(options = T.unsafe(nil), &block); end

  # source://statesman//lib/statesman/machine.rb#98
  def before_transition(options = T.unsafe(nil), &block); end

  # source://statesman//lib/statesman/machine.rb#60
  def callbacks; end

  # source://statesman//lib/statesman/machine.rb#103
  def guard_transition(options = T.unsafe(nil), &block); end

  # Returns the value of attribute initial_state.
  #
  # source://statesman//lib/statesman/machine.rb#30
  def initial_state; end

  # source://statesman//lib/statesman/machine.rb#45
  def remove_state(state_name); end

  # @raise [ArgumentError]
  #
  # source://statesman//lib/statesman/machine.rb#84
  def remove_transitions(from: T.unsafe(nil), to: T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#36
  def state(name, options = T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#32
  def states; end

  # source://statesman//lib/statesman/machine.rb#56
  def successors; end

  # @raise [InvalidStateError]
  #
  # source://statesman//lib/statesman/machine.rb#71
  def transition(from: T.unsafe(nil), to: T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#125
  def validate_callback_condition(options = T.unsafe(nil)); end

  # Check that the transition is valid when 'from' and 'to' are given
  #
  # source://statesman//lib/statesman/machine.rb#157
  def validate_from_and_to_state(from, to); end

  # Check that the 'from' state is not terminal
  #
  # source://statesman//lib/statesman/machine.rb#141
  def validate_not_from_terminal_state(from); end

  # Check that the 'to' state is not initial
  #
  # source://statesman//lib/statesman/machine.rb#149
  def validate_not_to_initial_state(to); end

  private

  # source://statesman//lib/statesman/machine.rb#166
  def add_callback(callback_type: T.unsafe(nil), callback_class: T.unsafe(nil), from: T.unsafe(nil), to: T.unsafe(nil), &block); end

  # source://statesman//lib/statesman/machine.rb#228
  def array_to_s_or_nil(input); end

  # source://statesman//lib/statesman/machine.rb#188
  def filter_callbacks(callbacks, from: T.unsafe(nil), to: T.unsafe(nil)); end

  # @raise [ArgumentError]
  #
  # source://statesman//lib/statesman/machine.rb#179
  def remove_callbacks(from: T.unsafe(nil), to: T.unsafe(nil)); end

  # source://statesman//lib/statesman/machine.rb#224
  def to_s_or_nil(input); end

  # @raise [ArgumentError]
  #
  # source://statesman//lib/statesman/machine.rb#206
  def validate_callback_type_and_class(callback_type, callback_class); end

  # source://statesman//lib/statesman/machine.rb#217
  def validate_initial_state(state); end

  # source://statesman//lib/statesman/machine.rb#211
  def validate_state(state); end
end

# source://statesman//lib/statesman/exceptions.rb#12
class Statesman::MissingTransitionAssociation < ::StandardError; end

# source://statesman//lib/statesman/railtie.rb#4
class Statesman::Railtie < ::Rails::Railtie; end

# source://statesman//lib/statesman/exceptions.rb#10
class Statesman::TransitionConflictError < ::StandardError; end

# source://statesman//lib/statesman/exceptions.rb#14
class Statesman::TransitionFailedError < ::StandardError
  # @return [TransitionFailedError] a new instance of TransitionFailedError
  #
  # source://statesman//lib/statesman/exceptions.rb#15
  def initialize(from, to); end

  # Returns the value of attribute from.
  #
  # source://statesman//lib/statesman/exceptions.rb#21
  def from; end

  # Returns the value of attribute to.
  #
  # source://statesman//lib/statesman/exceptions.rb#21
  def to; end

  private

  # source://statesman//lib/statesman/exceptions.rb#25
  def _message; end
end

# source://statesman//lib/statesman/exceptions.rb#46
class Statesman::UnserializedMetadataError < ::StandardError
  # @return [UnserializedMetadataError] a new instance of UnserializedMetadataError
  #
  # source://statesman//lib/statesman/exceptions.rb#47
  def initialize(transition_class_name); end

  private

  # source://statesman//lib/statesman/exceptions.rb#53
  def _message(transition_class_name); end
end

# source://statesman//lib/statesman/utils.rb#4
module Statesman::Utils
  class << self
    # @return [Boolean]
    #
    # source://statesman//lib/statesman/utils.rb#13
    def rails_4_or_higher?; end

    # @return [Boolean]
    #
    # source://statesman//lib/statesman/utils.rb#9
    def rails_5_or_higher?; end

    # source://statesman//lib/statesman/utils.rb#5
    def rails_major_version; end
  end
end

# source://statesman//lib/statesman/version.rb#4
Statesman::VERSION = T.let(T.unsafe(nil), String)