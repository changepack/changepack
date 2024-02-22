# typed: false
# frozen_string_literal: true

class Source
  module Filter
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      has_many :filters, class_name: '::Filter', dependent: :destroy
      after_create :filter_defaults!
    end

    sig { overridable.returns T::Array[::Filter] }
    def filter_defaults!
      ::Filter.defaults.each { |filter| filter.update(source: self) }
    end
  end
end
