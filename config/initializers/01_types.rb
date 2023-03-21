module T
  String = T.type_alias { ::String }
  Symbol = T.type_alias { ::Symbol }
  Integer = T.type_alias { ::Integer }
  Time = T.type_alias { T.any(::Time, DateTime, ActiveSupport::TimeWithZone) }
  Key = T.type_alias { T.any(::String, ::Symbol) }
  Shape = T.type_alias { T::Hash[Key, Class] }
  Payload = T.type_alias { T::Hash[T::Key, T.untyped] }
  Params = T.type_alias { T.any(::Hash, ActionController::Parameters) }
  Locals = T.type_alias { { locals: ::Hash } }

  def self.instance(__typed)
    ar_type_value = Class.new(ActiveRecord::Type::Value) do
      attr_reader :__typed

      def initialize(__typed:, **opts)
        @__typed = __typed
        super(**opts)
      end

      def cast(value)
        return value if value.is_a?(__typed)
        raise ArgumentError, "Value must be an instance of #{__typed}"
      end

      # These methods are required by ActiveRecord::Type::Value,
      # but we don't need to implement them since we're not
      # storing instances in the database.
      def serialize(value); end
      def deserialize(value); end
    end

    ar_type_value.new(__typed:)
  end

  def self.const_missing(name)
    model_name = name.to_s.singularize
    type_name = "T::#{name}"

    if const_defined?(model_name)
      # This is a bit hacky, but we use standard Rails autoload to load
      # the model and then `ActiveModel::T` automatically defines the
      # associated type for it.
      const_get(model_name)
      return const_get(type_name) if const_defined?(type_name)
    end

    super(name)
  end

  class Struct
    extend T::Sig

    class << self
      # Consistency with `ActiveRecord::Attributes` and `Event`
      alias attribute const
    end
  end
end
