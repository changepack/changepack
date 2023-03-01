# frozen_string_literal: true

class LegacyApplicationComponent < ViewComponent::Base
  extend Dry::Initializer
  include Pagy::Backend

  def self.option(name, type = nil, **opts, &)
    dry_initializer.option(name, type, **transform_opts(type, opts), &)
    self
  end

  def self.transform_opts(type, opts)
    opts.merge(optional: type.respond_to?(:optional?) ? type.optional? : opts[:optional])
        .compact
  end
end
