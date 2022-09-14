# frozen_string_literal: true

module Changelogs
  class Upsert < Command
    option :changelog, Types::Instance(Changelog)
    option :user, Types::Instance(User)
    option :content, Types::String
    option :title, Types::String.optional
    option :published, Types::String.optional
    option :commits, Types::Array.of(Types::String).optional

    def run
      changelog.tap do |changelog|
        changelog.update(attributes)
        changelog.transition_to!(:published) if publish?
        changelog.transition_to!(:draft) if draft?

        deattach_irrelevant_commits
        attach_new_commits
      end
    end

    private

    def attributes
      { title:, content:, account:, user: }
    end

    def user
      changelog.user || @user
    end

    def deattach_irrelevant_commits
      changelog.commits
               .where.not(id: commits)
               .each { |commit| commit.update!(changelog: nil) }
    end

    def attach_new_commits
      account.commits
             .where(id: commits)
             .includes(:account, :repository)
             .each { |commit| commit.update!(changelog:) }
    end

    def publish?
      published.present? && changelog.can_transition_to?(:published)
    end

    def draft?
      published.blank? && changelog.can_transition_to?(:draft)
    end

    delegate :account, to: :user
  end
end
