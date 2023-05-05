# typed: false
# frozen_string_literal: true

module Provided
  extend ActiveSupport::Concern
  extend T::Sig

  class Provided < Event
    attribute :id, String
    attribute :providers, Hash
  end

  included do
    attribute :providers, :jsonb, default: -> { {} }
    after_commit :provided!, on: :update, if: :providers_previously_changed?
    inquirer :provider
  end

  class_methods do
    extend T::Sig

    sig { params(name: T::Key).returns(T::Boolean) }
    def provider(name)
      define_method(name) { providers[name.to_s] }
      define_singleton_method(name) { where('providers -> ? IS NOT NULL', name) }
      define_method("#{name}?") { providers[name.to_s].present? }

      true
    end
  end

  sig { returns String }
  def provider
    providers.keys.first
  end

  sig { returns String }
  def provided!
    pub Provided.new(id:, providers:)
  end
end
