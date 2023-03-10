# frozen_string_literal: true

class Changelog
  module Publish
    extend ActiveSupport::Concern

    included do
      after_commit :detach, on: :update, if: :discarded_previously_changed?
    end

    def publish(publishable)
      if publishable.present? && can_transition_to?(:published)
        transition_to!(:published)
      elsif publishable.blank? && can_transition_to?(:draft)
        transition_to!(:draft)
      end
    end

    def attach(commits)
      account.commits
             .where(id: commits)
             .find_each { |commit| commit.update!(changelog: self) }
    end

    def detach(except: [])
      commits.where.not(id: except)
             .find_each { |commit| commit.update!(changelog_id: nil) }
    end
  end
end
