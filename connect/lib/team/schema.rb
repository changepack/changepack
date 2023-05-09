# typed: false
# frozen_string_literal: true

class Team
  class State
    include ValueObject

    attribute :type, :string
    attribute :required, :strings, default: []
    attribute :properties, :hash, default: -> { {} }
  end

  class Schema
    include ValueObject

    attribute :done, State.to_type, default: -> { {} }

    sig { returns T::Hash[Symbol, T.any(T::Key, T::Array, Hash)] }
    def self.to_shape
      {
        done: {
          type: T::Key,
          required: T::Array[T::Key],
          properties: {
            id: { const: String }
          }
        }
      }
    end
  end
end
