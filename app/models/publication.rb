# frozen_string_literal: true

class Publication
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :content, :string
  attribute :published, :boolean, default: false
  attribute :commits, array: true, default: -> { [] }
  attribute :changelog
  attribute :account
  attribute :user

  def update!
    Changelog.transaction do
      changelog.update(content: completion, title:, account:, user:)
      changelog.publish(published)
      changelog.detach(except: commits)
      changelog.attach(commits)
    end
  end

  alias create! update!

  private

  def completion
    if content.present? || commits.none?
      content
    else
      Sydney.new(account:).hallucinate(changes)
    end
  end

  def changes
    account.commits.where(id: commits).pluck(:message)
  end
end
