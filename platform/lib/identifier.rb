# typed: false
# frozen_string_literal: true

module Identifier
  extend ActiveSupport::Concern
  extend T::Helpers

  abstract!

  included do
    include PrettyId
  end

  class_methods do
    extend T::Sig

    sig { overridable.params(id: Symbol).returns(Symbol) }
    def key(id)
      self.id_prefix = id
      self.id_separator = '_'

      id
    end
  end
end
