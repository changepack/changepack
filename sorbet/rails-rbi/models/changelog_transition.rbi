# This is an autogenerated file for dynamic methods in ChangelogTransition
# Please rerun bundle exec rake rails_rbi:models[ChangelogTransition] to regenerate.

# typed: strong
module ChangelogTransition::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module ChangelogTransition::GeneratedAttributeMethods
  sig { returns(String) }
  def changelog_id; end

  sig { params(value: T.any(String, Symbol)).void }
  def changelog_id=(value); end

  sig { returns(T::Boolean) }
  def changelog_id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(String) }
  def id; end

  sig { params(value: T.any(String, Symbol)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(T.any(T::Array[T.untyped], T::Boolean, Float, T::Hash[T.untyped, T.untyped], Integer, String))) }
  def metadata; end

  sig { params(value: T.nilable(T.any(T::Array[T.untyped], T::Boolean, Float, T::Hash[T.untyped, T.untyped], Integer, String))).void }
  def metadata=(value); end

  sig { returns(T::Boolean) }
  def metadata?; end

  sig { returns(T::Boolean) }
  def most_recent; end

  sig { params(value: T::Boolean).void }
  def most_recent=(value); end

  sig { returns(T::Boolean) }
  def most_recent?; end

  sig { returns(Integer) }
  def sort_key; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def sort_key=(value); end

  sig { returns(T::Boolean) }
  def sort_key?; end

  sig { returns(String) }
  def to_state; end

  sig { params(value: T.any(String, Symbol)).void }
  def to_state=(value); end

  sig { returns(T::Boolean) }
  def to_state?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module ChangelogTransition::GeneratedAssociationMethods
  sig { returns(::Changelog) }
  def changelog; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Changelog).void)).returns(::Changelog) }
  def build_changelog(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Changelog).void)).returns(::Changelog) }
  def create_changelog(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Changelog).void)).returns(::Changelog) }
  def create_changelog!(*args, &block); end

  sig { params(value: ::Changelog).void }
  def changelog=(value); end

  sig { returns(::Changelog) }
  def reload_changelog; end

  sig { returns(::PaperTrail::Version::ActiveRecord_Associations_CollectionProxy) }
  def versions; end

  sig { returns(T::Array[Integer]) }
  def version_ids; end

  sig { params(value: T::Enumerable[::PaperTrail::Version]).void }
  def versions=(value); end
end

module ChangelogTransition::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[ChangelogTransition]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[ChangelogTransition]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[ChangelogTransition]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(ChangelogTransition)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(ChangelogTransition) }
  def find_by_id!(id); end
end

class ChangelogTransition < ApplicationRecord
  include ChangelogTransition::GeneratedAttributeMethods
  include ChangelogTransition::GeneratedAssociationMethods
  extend ChangelogTransition::CustomFinderMethods
  extend ChangelogTransition::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(ChangelogTransition::ActiveRecord_Relation, ChangelogTransition::ActiveRecord_Associations_CollectionProxy, ChangelogTransition::ActiveRecord_AssociationRelation) }

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def self.discarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def self.kept(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def self.undiscarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def self.with_discarded(*args); end
end

class ChangelogTransition::ActiveRecord_Relation < ActiveRecord::Relation
  include ChangelogTransition::ActiveRelation_WhereNot
  include ChangelogTransition::CustomFinderMethods
  include ChangelogTransition::QueryMethodsReturningRelation
  Elem = type_member {{fixed: ChangelogTransition}}

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def discarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def kept(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def undiscarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def with_discarded(*args); end
end

class ChangelogTransition::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include ChangelogTransition::ActiveRelation_WhereNot
  include ChangelogTransition::CustomFinderMethods
  include ChangelogTransition::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: ChangelogTransition}}

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def discarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def kept(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def undiscarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def with_discarded(*args); end
end

class ChangelogTransition::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include ChangelogTransition::CustomFinderMethods
  include ChangelogTransition::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: ChangelogTransition}}

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def discarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def kept(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def undiscarded(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def with_discarded(*args); end

  sig { params(records: T.any(ChangelogTransition, T::Array[ChangelogTransition])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(ChangelogTransition, T::Array[ChangelogTransition])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(ChangelogTransition, T::Array[ChangelogTransition])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(ChangelogTransition, T::Array[ChangelogTransition])).returns(T.self_type) }
  def concat(*records); end
end

module ChangelogTransition::QueryMethodsReturningRelation
  sig { returns(ChangelogTransition::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(ChangelogTransition::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: ChangelogTransition).returns(T::Boolean)).returns(T::Array[ChangelogTransition]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(ChangelogTransition::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(ChangelogTransition::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(ChangelogTransition::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(ChangelogTransition::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: ChangelogTransition::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module ChangelogTransition::QueryMethodsReturningAssociationRelation
  sig { returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(ChangelogTransition::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: ChangelogTransition).returns(T::Boolean)).returns(T::Array[ChangelogTransition]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(ChangelogTransition::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: ChangelogTransition::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end
