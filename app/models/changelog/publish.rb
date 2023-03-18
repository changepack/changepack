# typed: false
# frozen_string_literal: true

class Changelog
  module Publish
    extend ActiveSupport::Concern
    extend T::Sig

    included do
      after_commit :detach, on: :update, if: :discarded_at_previously_changed?
    end

    sig { params(publishable: T::Boolean).returns(T::Boolean) }
    def publish(publishable)
      if publishable.present? && can_transition_to?(:published)
        transition_to!(:published)
      elsif publishable.blank? && can_transition_to?(:draft)
        transition_to!(:draft)
      end

      false
    end

    sig { params(commits: T::Array[String]).void }
    def attach(commits)
      account.commits
             .where(id: commits)
             .find_each { |commit| commit.update!(changelog: self) }
    end

    sig { params(except: T::Array[String]).void }
    def detach(except: [])
      commits.where.not(id: except)
             .find_each { |commit| commit.update!(changelog_id: nil) }
    end
  end
end
