# frozen_string_literal: true

module Changelogs
  class Upsert < Command
    option :changelog, model: Changelog
    option :user, model: User
    option :content, type: Types::String
    option :title, type: Types::String, optional: true
    option :published, type: Types::String, optional: true
    option :commit_ids, type: Types::Array.of(Types::String), optional: true

    def execute
      changelog.tap do |changelog|
        changelog.update(attributes)
        changelog.transition_to!(:published) if publish?
        changelog.transition_to!(:draft) if draft?

        update_commits

        after_commit { event.publish if event.present? }
      end
    end

    private

    def attributes
      { title:, content:, account:, user: }
    end

    def user
      changelog.user || @user
    end

    def update_commits
      changelog.commits
               .where.not(id: commit_ids)
               .each { |commit| commit.update!(changelog: nil) }

      account.commits
             .where(id: commit_ids)
             .includes(:account, :repository)
             .each { |commit| commit.update!(changelog:) }
    end

    def event
      attrs = { id: changelog.id }

      return Published.new(attrs) if published?
      return Drafted.new(attrs) if drafted?
      return Created.new(attrs) if created?
    end

    def publish?
      @publish ||= published.present? && changelog.can_transition_to?(:published)
    end

    def draft?
      @draft ||= published.blank? && changelog.can_transition_to?(:draft)
    end

    alias published? publish?
    alias drafted? draft?

    def created?
      changelog.id_previously_changed?
    end

    delegate :account, to: :user
  end
end
