module Types
  include Dry.Types()

  def self.Relation(model)
    Types::Instance(ActiveRecord::Relation) | Types::Instance(ActiveRecord::AssociationRelation) | Types::Array.of(Types::Instance(model))
  end
end

module T
  module Changepack
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def nilable
        ::T.nilable(superclass)
      end

      def array
        ::T::Array[superclass]
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
