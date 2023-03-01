# frozen_string_literal: true

class Changelog
  module Publish
    extend ActiveSupport::Concern

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
             .includes(:account, :repository)
             .find_each { |commit| commit.update!(changelog: self) }
    end

    def detach(except: [])
      commits.where.not(id: except)
             .find_each { |commit| commit.update!(changelog: nil) }
    end
  end
end
