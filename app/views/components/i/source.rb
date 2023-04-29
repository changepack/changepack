# typed: false
# frozen_string_literal: true

module I
  class Source < ApplicationComponent
    attribute :source, T::Source

    delegate :repository, to: :source

    def template
      case source.type
      when 'repository'
        render I::Repository.new(repository:)
      end
    end
  end
end
