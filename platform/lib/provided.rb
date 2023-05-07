# typed: false
# frozen_string_literal: true

module Provided
  extend ActiveSupport::Concern
  extend T::Helpers
  extend T::Sig

  abstract!

  class Provided < Event
    attribute :id, String
    attribute :provider, String
    attribute :providers, Hash
  end

  included do
    attribute :providers, :jsonb, default: -> { {} }
    after_commit :provided!, on: :update, if: :providers_previously_changed?
    inquirer :provider
  end

  class_methods do
    extend T::Sig

    sig { overridable.params(name: T::Key).returns(T::Boolean) }
    def provider(name)
      define_method(name) { providers[name.to_s] }
      define_singleton_method(name) { where('providers -> ? IS NOT NULL', name) }
      define_method("#{name}?") { providers[name.to_s].present? }

      true
    end
  end

  sig { overridable.returns String }
  def provider
    providers.keys.first
  end

  sig { overridable.returns String }
  def provided!
    provider = (providers.keys - providers_previously_was.keys).sole
    pub Provided.new(id:, provider:, providers:)
  end
end
