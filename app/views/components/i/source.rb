# typed: false
# frozen_string_literal: true

module I
  class Source < ApplicationComponent
    attribute :source, ::Source

    delegate :repository, :team, to: :source

    def template
      case source.type
      when 'repository'
        render I::Repository.new(repository:)
      when 'team'
        render I::Team.new(team:)
      end
    end
  end
end
