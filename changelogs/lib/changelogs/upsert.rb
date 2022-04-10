# frozen_string_literal: true

module Changelogs
  class Upsert < Command
    params changelog: Types::Instance(Changelog),
           user: Types::Instance(User),
           title: Types::String.optional,
           content: Types::String,
           published?: Types::String.optional

    def perform
      changelog.update(attributes).tap do
        changelog.transition_to!(:published) if publish?
        changelog.transition_to!(:draft) if draft?

        after_commit { Event.publish(event) if event.present? }
      end
    end

    private

    def attributes
      { title:, content:, account:, user: }
    end

    def user
      @user ||= changelog.user || params.user
    end

    def event
      return Published.new(event_attributes) if published?
      return Drafted.new(event_attributes) if drafted?
      return Created.new(event_attributes) if created?
    end

    def event_attributes
      { id: changelog.id }
    end

    def publish?
      @publish ||= params.fetch(:published, false).present? && changelog.can_transition_to?(:published)
    end

    def draft?
      @draft ||= params.fetch(:published, false).blank? && changelog.can_transition_to?(:draft)
    end

    def created?
      changelog.id_previously_changed?
    end

    delegate :changelog, :title, :content, to: :params
    delegate :account, to: :user

    alias published? publish?
    alias drafted? draft?
  end
end
