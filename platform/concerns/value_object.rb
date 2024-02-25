# typed: false
# frozen_string_literal: true

module ValueObject
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  abstract!

  included do
    include ActiveRecord::AttributeMethods::Dirty
    include ActiveModel::Validations::Callbacks
    include ActiveRecord::Normalization
    include StoreModel::Model
    include Inquirer

    class_eval do
      extend T::Helpers
      extend T::Sig
    end
  end
end
