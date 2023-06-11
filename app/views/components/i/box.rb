# typed: false
# frozen_string_literal: true

module I
  class Box < ApplicationComponent
    def template(&)
      div class: 'box', data: { test_id: 'repository' } do
        table class: 'w-full' do
          tbody do
            tr class: 'focus:outline-none h-16', &
          end
        end
      end
    end
  end
end
