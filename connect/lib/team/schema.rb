# typed: false
# frozen_string_literal: true

class Team
  class State
    include ValueObject

    attribute :type, :string
    attribute :required, :strings, default: []
    attribute :properties, :hash, default: -> { {} }

    sig { params(value: T.any(Hash, String)).returns(T::Boolean) }
    def validate(value)
      JSON::Validator.validate(as_json, value)
    end
  end

  class Schema
    include ValueObject

    attribute :done, State.to_type, default: -> { {} }
  end
end
