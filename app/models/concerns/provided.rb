# typed: false
# frozen_string_literal: true

module Provided
  extend ActiveSupport::Concern

  included do
    attribute :providers, :jsonb, default: -> { {} }
    inquirer :provider
  end

  class_methods do
    def provider(name)
      define_method(name) { providers[name.to_s] }
      define_singleton_method(name) { where('providers -> ? IS NOT NULL', name) }
      define_method("#{name}?") { providers[name.to_s].present? }
    end
  end

  def providers
    @providers ||= Hashie::Mash.new(super)
  end

  def provider
    @provider ||= providers.keys.first
  end
end
