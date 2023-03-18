module Types
  include Dry.Types()

  def self.Relation(model)
    Types::Instance(ActiveRecord::Relation) | Types::Instance(ActiveRecord::AssociationRelation) | Types::Array.of(Types::Instance(model))
  end
end

module T
  module Changepack
    extend ActiveSupport::Concern

    class_methods do
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

  class String < ::String
    include Changepack
  end

  class Symbol < ::Symbol
    include Changepack
  end

  class Integer < ::Integer
    include Changepack
  end
end

module ActiveModel
  module T
    extend ActiveSupport::Concern

    included do
      extend ::T::Sig
      # Define the nested T::[Model] class within the T module
      ::T.const_set("#{name}", Class.new(self) do
        include ::T::Changepack
      end)
    end
  end
end

module Dry
  class Struct
    extend T::Sig
  end
end
