# typed: false
# frozen_string_literal: true

class Hook
  class Base
    include ValueObject

    attribute :provider, :string
    validates :provider, presence: true
    inquirer :provider
  end
end
