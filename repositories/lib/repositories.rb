# frozen_string_literal: true

module Repositories
  class Pulled < Event
    attribute :id, Types::String
  end
end
