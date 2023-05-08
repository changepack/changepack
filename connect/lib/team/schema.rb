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
  end
end
