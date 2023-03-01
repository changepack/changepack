# frozen_string_literal: true

class Publication
  include ActiveModel::Model

  attr_accessor :changelog, :title, :content, :account, :user, :published, :commits

  def create!
    Changelog.transaction do
      changelog.assign_attributes(title:, content:, account:, user:)
      changelog.save! if changelog.valid?

      changelog.publish(published)
      handle_commits
    end
  end

  alias update! create!

  private

  def handle_commits
    return if commits.blank?

    changelog.detach(except: commits)
    changelog.attach(commits)
  end
end
