# frozen_string_literal: true

module Changelogs
  class Created < Event
    attribute :id, Types::String
  end

  class Drafted < Event
    attribute :id, Types::String
  end

  class Published < Event
    attribute :id, Types::String
  end
end