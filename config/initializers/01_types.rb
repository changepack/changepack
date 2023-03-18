module Types
  include Dry.Types()

  def self.Relation(model)
    Types::Instance(ActiveRecord::Relation) | Types::Instance(ActiveRecord::AssociationRelation) | Types::Array.of(Types::Instance(model))
  end
end

module T
  module Changepack
    module ClassMethods
      extend ActiveSupport::Concern

      class_methods do
        def |(other)
          T.any(superclass, other)
        end

        def nilable
          ::T.nilable(superclass)
        end

        def array
          ::T::Array[superclass]
        end

        def relation
          T.any(
            superclass::const_get(:ActiveRecord_Associations_CollectionProxy),
            superclass::const_get(:ActiveRecord_Relation),
            ActiveRecord::AssociationRelation,
            ActiveRecord::Relation,
            ::T::Array[superclass]
          )
        end
      end
    end

    module Instance
      def |(other)
        T.any(self, other)
      end

      def nilable
        ::T.nilable(self)
      end

      def array
        ::T::Array[self]
      end
    end
  end

  String = T.type_alias { ::String }
  Symbol = T.type_alias { ::Symbol }
  Integer = T.type_alias { ::Integer }
  Time = T.type_alias { T.any(::Time, DateTime, ActiveSupport::TimeWithZone) }

  module Array
    include Changepack::ClassMethods

    def self.superclass
      self
    end
  end

  module Hash
    include Changepack::ClassMethods

    def self.superclass
      self
    end
  end

  module Enumerable
    include Changepack::ClassMethods

    def self.superclass
      self
    end
  end

  module Enumerator
    include Changepack::ClassMethods

    def self.superclass
      self
    end

    module Lazy
      include Changepack::ClassMethods

      def self.superclass
        self
      end
    end

    module Chain
      include Changepack::ClassMethods

      def self.superclass
        self
      end
    end
  end

  module Range
    include Changepack::ClassMethods

    def self.superclass
      self
    end
  end

  module Set
    include Changepack::ClassMethods

    def self.superclass
      self
    end
  end

  module Types
    class TypedHash
      include Changepack::Instance
    end

    class TypedArray
      include Changepack::Instance
    end

    class Union
      include Changepack::Instance
    end
  end

  module Private
    module Types
      class SimplePairUnion
        include Changepack::Instance
      end

      class TypeAlias
        def |(other)
          T.any(aliased_type, other)
        end

        def nilable
          ::T.nilable(aliased_type)
        end

        def array
          ::T::Array[aliased_type]
        end
      end
    end
  end
end

module ActiveModel
  module T
    extend ActiveSupport::Concern

    def self.create_nested_module(mod, name_parts)
      if name_parts.count == 1
        return mod
      else
        next_part = name_parts.shift
        next_mod = mod.const_get(next_part) rescue nil

        unless next_mod
          next_mod = Module.new
          mod.const_set(next_part, next_mod)
        end

        create_nested_module(next_mod, name_parts)
      end
    end

    included do
      extend ::T::Sig
      # Define the nested T::[Model] class within the T module
      nested_mod = ActiveModel::T.create_nested_module(::T, name.split('::'))
      nested_mod.const_set("#{name.demodulize}", Class.new(self) do
        include ::T::Changepack::ClassMethods
      end)
    end
  end
end

module StoreModel
  T = ActiveModel::T
end

module Dry
  class Struct
    extend T::Sig
    # Dry::Struct works similar to how T::Struct works in the Sorbet runtime library.
    # Given that T::Struct can be used as a Sorbet type, it makes sense to treat
    # Dry::Struct like a Sorbet type as well.
    include T::Changepack::ClassMethods
  end
end
