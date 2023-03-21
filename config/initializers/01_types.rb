module T
  String = T.type_alias { ::String }
  Symbol = T.type_alias { ::Symbol }
  Integer = T.type_alias { ::Integer }
  Time = T.type_alias { T.any(::Time, DateTime, ActiveSupport::TimeWithZone) }
  Key = T.type_alias { T.any(String, Symbol) }
  Shape = T.type_alias { T::Hash[Key, Class] }
  Payload = T.type_alias { T::Hash[T::Key, T.untyped] }

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
    model_name = name.singularize
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

  module Changepack
    module Callable
      def call(val)
        T.let(val, self)
      end
    end
  end

  module Array
    include Changepack::Callable
  end

  module Hash
    include Changepack::Callable
  end

  module Enumerable
    include Changepack::Callable
  end

  module Enumerator
    include Changepack::Callable

    module Lazy
      include Changepack::Callable
    end

    module Chain
      include Changepack::Callable
    end
  end

  module Range
    include Changepack::Callable
  end

  module Set
    include Changepack::Callable
  end

  class Struct
    include Changepack::Callable

    extend T::Sig

    class << self
      # Consistency with `ActiveRecord::Attributes` and `Event`
      alias attribute const
    end
  end

  module Types
    class TypedHash
      include Changepack::Callable
    end

    class TypedArray
      include Changepack::Callable
    end

    class Union
      include Changepack::Callable
    end

    class Untyped
      include Changepack::Callable
    end
  end

  module Private
    module Types
      class SimplePairUnion
        include Changepack::Callable
      end

      class TypeAlias
        include Changepack::Callable
      end
    end
  end
end
