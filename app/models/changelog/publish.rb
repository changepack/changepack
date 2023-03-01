# frozen_string_literal: true

class Changelog
  module Publish
    extend ActiveSupport::Concern

    def publish(publishable)
      if can_transition_to?(:published) && publishable.present?
        transition_to!(:published)
      elsif can_transition_to?(:draft) && publishable.blank?
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
