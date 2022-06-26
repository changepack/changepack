# frozen_string_literal: true

module Commits
  class OnNewHour
    def call(_event)
      Repository.active.find_each do |repository|
        Commits::Pull.new(repository:).execute
      end
    end
  end
end
