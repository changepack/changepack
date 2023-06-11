# typed: false
# frozen_string_literal: true

module I
  class Box < ApplicationComponent
    attribute :data, T.nilable(Hash), default: -> { {} }
    attribute :cols, T::Array[Integer], default: -> { [] }

    def template(&)
      div class: 'box', data: do
        table class: 'w-full' do
          colgroups
          tbody do
            tr class: 'focus:outline-none h-16', &
          end
        end
      end
    end

    def colgroups
      return if cols.blank?

      colgroup do
        cols.each do |width|
          col class: "w-#{width}"
        end
      end
    end
  end
end
