# typed: false
# frozen_string_literal: true

module I
  class Tag < ApplicationComponent
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
      super
    end

    def template(&)
      span(**classes('tag', class?: @class), &)
    end

    def class?
      @class.present?
    end
  end
end
