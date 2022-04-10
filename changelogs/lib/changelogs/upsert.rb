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
        create! if create?
        publish! if publish?
        draft! if draft?
      end
    end

    private

    def attributes
      {
        title: params.title,
        content: params.content,
        user:,
        account: user.account
      }
    end

    def user
      @user ||= changelog.user || params.user
    end

    def create!
      after_commit do
        Rails.configuration.event_store.publish(
          PostCreated.new(data: { id: changelog.id })
        )
      end
    end

    def create?
      changelog.id_previously_changed?
    end

    def publish!
      changelog.transition_to!(:published)

      after_commit do
        Rails.configuration.event_store.publish(
          PostPublished.new(data: { id: changelog.id })
        )
      end
    end

    def publish?
      params.fetch(:published, false).present? && changelog.can_transition_to?(:published)
    end

    def draft!
      changelog.transition_to!(:draft)

      after_commit do
        Rails.configuration.event_store.publish(
          PostDrafted.new(data: { id: changelog.id })
        )
      end
    end

    def draft?
      params.fetch(:published, false).blank? && changelog.can_transition_to?(:draft)
    end

    delegate :changelog, :user, to: :params
  end
end
