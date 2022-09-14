# frozen_string_literal: true

module Adapters
  def self.[](provider)
    providers.fetch(provider.to_sym)
  end

  def self.providers
    {
      github: Adapters::GitHub
    }
  end
end
