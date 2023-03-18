# typed: false
# frozen_string_literal: true

module Identifier
  extend ActiveSupport::Concern

  included do
    include PrettyId
  end

  class_methods do
    extend T::Sig

    sig { params(id: T::Symbol).returns(T::String) }
    def key(id)
      self.id_prefix = id
      self.id_separator = '_'
    end
  end
end
