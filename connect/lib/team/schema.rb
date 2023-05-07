# typed: false
# frozen_string_literal: true

class Team
  class Schema
    class Status
      include ValueObject

      attribute :type, :string
      attribute :required, :strings, default: []
      attribute :properties, :hash, default: -> { {} }
    end

    include ValueObject

    attribute :done, Status.to_type, default: -> { {} }
  end
end
