# typed: false
# frozen_string_literal: true

class Issue
  class Assignee
    include ValueObject

    attribute :name, :string
    validates :name, presence: true
    normalize :name
  end
end
