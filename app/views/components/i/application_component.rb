# typed: false
# frozen_string_literal: true

module I
  class ApplicationComponent < Phlex::HTML
    include Phlex::Rails::Helpers::Routes
    include Pagy::Backend

    extend Dry::Initializer
    extend T::Sig

    register_element :turbo_frame

    def self.attribute(name, type = nil, **opts, &)
      dry_initializer.option(name, ->(val) { T.let(val, type) }, **transform_opts(type, opts), &)
      self
    end

    def self.transform_opts(type, opts)
      nilable = T::Utils.coerce(NilClass)
      optional = if type.respond_to?(:types) && type.types.is_a?(Array) && nilable.in?(type.types)
                   true
                 else
                   opts[:optional]
                 end

      opts.merge(optional:).compact
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

    def tag(class: nil, &)
      render ::I::Tag.new(class: binding.local_variable_get(:class), &)
    end
  end
end
