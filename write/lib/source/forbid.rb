# typed: false
# frozen_string_literal: true

class Source
  module Forbid
    extend ActiveSupport::Concern
    extend T::Sig

    included do
      after_create :forbid_defaults!
    end

    sig { returns T::Array[Forbidden] }
    def forbid_defaults!
      Forbidden.defaults.each { |forbidden| forbidden.update(source: self) }
    end
  end
end
