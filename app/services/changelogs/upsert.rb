# typed: false
# frozen_string_literal: true

module Changelogs
  class Upsert < Operation
    params changelog: Types::Instance(Changelog),
           user: Types::Instance(User),
           title: Types::String.optional,
           content: Types::String,
           published?: Types::String.optional

    def perform
      changelog.update(attributes).tap do
        changelog.transition_to(:published) if publish?
        changelog.transition_to(:draft) if draft?
      end
    end

    private

    def attributes
      {
        title: params.title,
        content: params.content,
        user: changelog.user || params.user
      }
    end

    def publish?
      params.fetch(:published, false).present? && changelog.can_transition_to?(:published)
    end

    def draft?
      params.fetch(:published, false).blank? && changelog.can_transition_to?(:draft)
    end

    delegate :changelog, :user, to: :params
  end
end
