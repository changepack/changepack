# typed: false
# frozen_string_literal: true

module ValueObject
  extend ActiveSupport::Concern
  extend T::Sig

  included do
    include StoreModel::Model
    include ActiveModel::Validations::Callbacks
    include NormalizeAttributes::Callbacks
  end
end
