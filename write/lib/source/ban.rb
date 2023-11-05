# typed: false
# frozen_string_literal: true

class Source
  module Ban
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      has_many :banneds, dependent: :destroy
      after_create :ban_defaults!
    end

    sig { overridable.returns T::Array[Banned] }
    def ban_defaults!
      Banned.defaults.each { |banned| banned.update(source: self) }
    end
  end
end
