# typed: false
# frozen_string_literal: true

module Resourcable
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  abstract!

  included do
    after_commit :created!, on: :create
    after_commit :updated!, on: :update
    after_commit :destroyed!, on: :destroy
  end

  private

  sig { overridable.returns T.nilable(String) }
  def created!
    return if self.class.const_defined?(:Created).blank?

    pub self.class::Created.new(**self.class::Resource.to_event(self))
  end

  sig { overridable.returns T.nilable(String) }
  def updated!
    return if self.class.const_defined?(:Updated).blank?

    pub self.class::Updated.new(**self.class::Resource.to_event(self))
  end

  sig { overridable.returns T.nilable(String) }
  def destroyed!
    return if self.class.const_defined?(:Destroyed).blank?

    pub self.class::Destroyed.new(**self.class::Resource.to_event(self))
  end
end
