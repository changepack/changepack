# frozen_string_literal: true

module Provided
  extend ActiveSupport::Concern

  TYPES = %w[github].freeze

  included do
    attribute :providers, :jsonb, default: -> { {} }
    validate :ensure_providers_inclusion
    inquirer :provider
  end

  class_methods do
    def provider(*attrs)
      define_provider_attr_reader(*attrs)
      define_provider_scope(*attrs)
      define_provider_inquirer(*attrs)
      define_provider_finder(*attrs)
    end

    def define_provider_attr_reader(*attrs)
      define_method(attrs.join('_')) { providers.dig(*attrs.map(&:to_s)) }
    end

    def define_provider_scope(*attrs)
      define_singleton_method(attrs.join('_')) do
        where('providers -> ? IS NOT NULL', attrs.map { |n| "'#{n}'" }.join(' -> '))
      end
    end

    def define_provider_inquirer(*attrs)
      define_method("#{attrs.join('_')}?") { providers.dig(*attrs.map(&:to_s)).present? }
    end

    def define_provider_finder(*attrs)
      define_method("find_#{attrs.last}_for") { |provider| providers.dig(provider, attrs.last) }
    end
  end

  def self.types
    TYPES
  end

  def ensure_providers_inclusion
    return if providers.keys.all? { |type| Provided.types.include?(type) }

    errors.add(:providers, "can't contain invalid types")
  end

  def providers
    @providers ||= Hashie::Mash.new(super)
  end

  def provider
    @provider ||= providers.keys.first
  end
end
