# frozen_string_literal: true

module Changepack
  module Provider
    extend ActiveSupport::Concern

    TYPES = %w[github].freeze

    included do
      attribute :providers, :jsonb, default: -> { {} }

      validate :ensure_providers_inclusion

      inquirer :provider
    end

    class_methods do
      def provider(*attrs)
        name = attrs.join('_')
        query = attrs.map(&:to_s)

        define_method(name) { providers.dig(*query) }
        define_method("#{name}?") { providers.dig(*query).present? }
        define_method("find_#{attrs.last}_for") { |provider| providers.dig(provider, attrs.last) }
      end
    end

    def self.types
      TYPES
    end

    def ensure_providers_inclusion
      return if providers.keys.all? { |type| Provider.types.include?(type) }

      errors.add(:providers, "can't contain invalid types")
    end

    def providers
      @providers ||= Hashie::Mash.new(super)
    end

    def provider
      @provider ||= providers.keys.first
    end
  end
end
