# typed: false
# frozen_string_literal: true

class Source
  module Forbid
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      has_many :forbiddens, dependent: :destroy
      after_create :forbid_defaults!
    end

    sig { overridable.returns T::Array[Forbidden] }
    def forbid_defaults!
      Forbidden.defaults.each { |forbidden| forbidden.update(source: self) }
    end
  end
end
