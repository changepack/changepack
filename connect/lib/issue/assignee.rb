# typed: false
# frozen_string_literal: true

class Issue
  class Assignee
    include ValueObject

    attribute :name, :string
    attribute :email, :string

    validates :name, presence: true
    validates :email, presence: true

    normalize :name
    normalize :email
  end
end
