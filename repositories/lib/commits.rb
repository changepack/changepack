# frozen_string_literal: true

module Commits
  class Pulled < Event
    attribute :id, Types::String
  end
end
