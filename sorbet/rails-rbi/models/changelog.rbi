# This is an autogenerated file for dynamic methods in Changelog
# Please rerun bundle exec rake rails_rbi:models[Changelog] to regenerate.

# typed: strong
module Changelog::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Changelog::GeneratedAttributeMethods
  sig { returns(T.nilable(String)) }
  def account_id; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def account_id=(value); end

  sig { returns(T::Boolean) }
  def account_id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def discarded; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def discarded=(value); end

  sig { returns(T::Boolean) }
  def discarded?; end

  sig { returns(String) }
  def id; end

  sig { params(value: T.any(String, Symbol)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(String)) }
  def slug; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def slug=(value); end

  sig { returns(T::Boolean) }
  def slug?; end

  sig { returns(String) }
  def status; end

  sig { params(value: T.any(String, Symbol)).void }
  def status=(value); end

  sig { returns(T::Boolean) }
  def status?; end

  sig { returns(T.nilable(String)) }
  def title; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def title=(value); end

  sig { returns(T::Boolean) }
  def title?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end

  sig { returns(T.nilable(String)) }
  def user_id; end

  sig { params(value: T.nilable(T.any(String, Symbol))).void }
  def user_id=(value); end

  sig { returns(T::Boolean) }
  def user_id?; end
end

module Changelog::GeneratedAssociationMethods
  sig { returns(::Account) }
  def account; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Account).void)).returns(::Account) }
  def build_account(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Account).void)).returns(::Account) }
  def create_account(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Account).void)).returns(::Account) }
  def create_account!(*args, &block); end

  sig { params(value: ::Account).void }
  def account=(value); end

  sig { returns(::Account) }
  def reload_account; end

  sig { returns(::Commit::ActiveRecord_Associations_CollectionProxy) }
  def commits; end

  sig { returns(T::Array[String]) }
  def commit_ids; end

  sig { params(value: T::Enumerable[::Commit]).void }
  def commits=(value); end

  sig { returns(T.nilable(::ActionText::RichText)) }
  def rich_text_content; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::ActionText::RichText).void)).returns(::ActionText::RichText) }
  def build_rich_text_content(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::ActionText::RichText).void)).returns(::ActionText::RichText) }
  def create_rich_text_content(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::ActionText::RichText).void)).returns(::ActionText::RichText) }
  def create_rich_text_content!(*args, &block); end

  sig { params(value: T.nilable(::ActionText::RichText)).void }
  def rich_text_content=(value); end

  sig { returns(T.nilable(::ActionText::RichText)) }
  def reload_rich_text_content; end

  sig { returns(::ChangelogTransition::ActiveRecord_Associations_CollectionProxy) }
  def transitions; end

  sig { returns(T::Array[String]) }
  def transition_ids; end

  sig { params(value: T::Enumerable[::ChangelogTransition]).void }
  def transitions=(value); end

  sig { returns(T.nilable(::User)) }
  def user; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_user!(*args, &block); end

  sig { params(value: T.nilable(::User)).void }
  def user=(value); end

  sig { returns(T.nilable(::User)) }
  def reload_user; end

  sig { returns(::PaperTrail::Version::ActiveRecord_Associations_CollectionProxy) }
  def versions; end

  sig { returns(T::Array[Integer]) }
  def version_ids; end

  sig { params(value: T::Enumerable[::PaperTrail::Version]).void }
  def versions=(value); end
end

module Changelog::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Changelog]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Changelog]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Changelog]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(Changelog)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Changelog) }
  def find_by_id!(id); end
end

class Changelog < ApplicationRecord
  include Changelog::GeneratedAttributeMethods
  include Changelog::GeneratedAssociationMethods
  extend Changelog::CustomFinderMethods
  extend Changelog::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Changelog::ActiveRecord_Relation, Changelog::ActiveRecord_Associations_CollectionProxy, Changelog::ActiveRecord_AssociationRelation) }

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.for(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.kept(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.recent(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.undiscarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.with_discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.with_rich_text_content(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def self.with_rich_text_content_and_embeds(*args); end

  sig { params(args: T.untyped).returns(NilClass) }
  def self.has_rich_text(*args); end
end

class Changelog::ActiveRecord_Relation < ActiveRecord::Relation
  include Changelog::ActiveRelation_WhereNot
  include Changelog::CustomFinderMethods
  include Changelog::QueryMethodsReturningRelation
  Elem = type_member {{fixed: Changelog}}

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def for(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def kept(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def recent(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def undiscarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def with_discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def with_rich_text_content(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def with_rich_text_content_and_embeds(*args); end
end

class Changelog::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Changelog::ActiveRelation_WhereNot
  include Changelog::CustomFinderMethods
  include Changelog::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Changelog}}

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def for(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def kept(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def recent(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def undiscarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def with_discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def with_rich_text_content(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def with_rich_text_content_and_embeds(*args); end
end

class Changelog::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Changelog::CustomFinderMethods
  include Changelog::QueryMethodsReturningAssociationRelation
  Elem = type_member {{fixed: Changelog}}

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def for(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def kept(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def recent(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def undiscarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def with_discarded(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def with_rich_text_content(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def with_rich_text_content_and_embeds(*args); end

  sig { params(records: T.any(Changelog, T::Array[Changelog])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Changelog, T::Array[Changelog])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Changelog, T::Array[Changelog])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Changelog, T::Array[Changelog])).returns(T.self_type) }
  def concat(*records); end
end

module Changelog::QueryMethodsReturningRelation
  sig { returns(Changelog::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Changelog::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Changelog).returns(T::Boolean)).returns(T::Array[Changelog]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Changelog::ActiveRecord_Relation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Changelog::ActiveRecord_Relation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Changelog::ActiveRecord_Relation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Changelog::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Changelog::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Changelog::QueryMethodsReturningAssociationRelation
  sig { returns(Changelog::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Changelog::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Changelog::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(block: T.proc.params(e: Changelog).returns(T::Boolean)).returns(T::Array[Changelog]) }
  def select(&block); end

  sig { params(args: T.any(String, Symbol, T::Array[T.any(String, Symbol)])).returns(Changelog::ActiveRecord_AssociationRelation) }
  def select_columns(*args); end

  sig { params(args: Symbol).returns(Changelog::ActiveRecord_AssociationRelation) }
  def where_missing(*args); end

  sig { params(column: Symbol, values: T::Array[T.untyped]).returns(Changelog::ActiveRecord_AssociationRelation) }
  def in_order_of(column, values); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Changelog::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Changelog::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end
