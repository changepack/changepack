# typed: false
# frozen_string_literal: true

module Resource
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  abstract!

  included do
    class_eval do
      extend ActiveSupport::Concern
      extend T::Helpers
      extend T::Sig

      abstract!
    end
  end

  sig { abstract.params(resource: T.untyped).returns Hash }
  def self.to_event(resource); end
end
