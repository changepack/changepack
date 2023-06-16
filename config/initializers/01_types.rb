class StringsType < ActiveRecord::Type::Value
  def type
    :array_to_s
  end
end

class IntegersType < ActiveRecord::Type::Value
  def type
    :array_to_i
  end

  def cast(values)
    return if values.blank?
    values.map(&:to_i)
  end
end

class ObjectType < ActiveRecord::Type::Value
  def type
    :object
  end
end

ActiveModel::Type.register(:object, ObjectType)
ActiveModel::Type.register(:array_to_s, StringsType)
ActiveModel::Type.register(:array_to_i, IntegersType)

module T
  String = T.type_alias { ::String }
  Symbol = T.type_alias { ::Symbol }
  Integer = T.type_alias { ::Integer }
  Time = T.type_alias { T.any(::Time, DateTime) }
  Key = T.type_alias { T.any(::String, ::Symbol) }
  Shape = T.type_alias { T::Hash[Key, Class] }
  Payload = T.type_alias { T::Hash[T::Key, T.untyped] }
  Params = T.type_alias { T.any(::Hash, ActionController::Parameters) }
  Locals = T.type_alias { { locals: ::Hash } }

  def self.instance(__typed)
    ar_type_value = ::Class.new(ActiveRecord::Type::Value) do
      attr_reader :__typed

      def initialize(__typed:, **opts)
        @__typed = __typed
        super(**opts)
      end

      def cast(value)
        if __typed.is_a?(T::Types::Base)
          return value if eval?(value)
        else
          return value if value.is_a?(__typed)
        end

        raise ArgumentError, "Value must be an instance of #{__typed}"
      rescue TypeError
        raise ArgumentError, "Value must be an instance of #{__typed}"
      end

      # These methods are required by ActiveRecord::Type::Value,
      # but we don't need to implement them since we're not
      # storing instances in the database.
      def serialize(value); end
      def deserialize(value); end

      private

      def eval?(value)
        T.let(value, __typed)
        true
      rescue TypeError
        false
      end
    end

    ar_type_value.new(__typed:)
  end

  class Struct
    extend T::Sig

    class << self
      # Consistency with `ActiveRecord::Attributes` and `Event`
      alias attribute const
    end
  end
end
