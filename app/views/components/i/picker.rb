# typed: false
# frozen_string_literal: true

module I
  class Picker < ApplicationComponent
    class Choice < ApplicationComponent
      attribute :id, String
      attribute :opts, T::Array[T.any(T::Boolean, Hash)]
      attribute :attribute, T.any(Symbol, String)
      attribute :form, T.untyped

      def template(&)
        div class: 'mb-3' do
          unsafe_raw form.check_box(attribute, *opts)

          label for: id, class: 'ml-2', &
        end
      end
    end

    include Phlex::DeferredRender

    attr_reader :checkboxes

    attribute :title, String

    def initialize(...)
      @checkboxes = []

      super
    end

    def template(&)
      wrapper do
        h2 { title }
        section class: 'overflow-x-scroll max-h-80' do
          checkboxes.each { |checkbox| render checkbox }

          div class: '-mt-3'
        end
      end
    end

    def choice(...)
      @checkboxes << Choice.new(...)
    end

    def wrapper(&)
      div class: 'mt-10 hidden md:block' do
        div class: 'accordion accordion-mini' do
          div class: 'accordion-single', &
        end
      end
    end
  end
end
