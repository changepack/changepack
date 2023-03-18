# typed: false
# frozen_string_literal: true

class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::Routes
  include Pagy::Backend

  extend Dry::Initializer

  register_element :turbo_frame

  def self.attribute(name, type = nil, **opts, &)
    dry_initializer.option(name, type, **transform_opts(type, opts), &)
    self
  end

  def self.transform_opts(type, opts)
    opts.merge(optional: type.respond_to?(:optional?) ? type.optional? : opts[:optional])
        .compact
  end

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  def icon(name, **attributes)
    unsafe_raw helpers.icon(name, **attributes)
  end
end
