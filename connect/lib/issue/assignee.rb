# typed: false
# frozen_string_literal: true

class Issue
  class Assignee
    include ValueObject

    attribute :name, :string
    attribute :email, :string
    attribute :providers, :object, default: -> { {} }

    validates :name, presence: true
    validates :email, presence: true

    normalizes :name, with: ->(name) { name.squish }
    normalizes :email, with: ->(email) { email.squish.downcase }

    sig { returns T.nilable(String) }
    def linear
      providers.symbolize_keys.fetch(:linear, nil)
    end

    sig { returns T.nilable(String) }
    def changepack
      providers.symbolize_keys.fetch(:changepack, nil)
    end

    sig { returns T::Boolean }
    def linear?
      linear.present?
    end

    sig { returns T::Boolean }
    def changepack?
      changepack.present?
    end
  end
end
