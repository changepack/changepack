# frozen_string_literal: true

module Changelogs
  class Upsert < Operation
    params changelog: Types::Instance(Changelog),
           title: Types::String.optional,
           content: Types::String,
           published?: Types::String

    def perform
      changelog.transition_to(:published) if publish?
      changelog.update(attributes)
    end

    private

    def attributes
      {
        title: params.title,
        content: params.content
      }
    end

    def publish?
      params.fetch(:published, false).present? && changelog.can_transition_to?(:published)
    end

    delegate :changelog, to: :params
  end
end
