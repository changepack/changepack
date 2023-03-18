# typed: false
# frozen_string_literal: true

class Publication
  extend T::Sig

  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :content, :string
  attribute :published, :boolean, default: false
  attribute :commits, array: true, default: -> { [] }
  attribute :changelog
  attribute :account
  attribute :user

  sig { returns T::Boolean }
  def update!
    Changelog.transaction do
      changelog.update(content: completion, title:, account:, user:)
      changelog.publish(published)
      changelog.detach(except: commits)
      changelog.attach(commits)
    end

    true
  end

  alias create! update!

  private

  sig { returns T.nilable(String) }
  def completion
    if content.present? || commits.none?
      content
    else
      Sydney.new(account:).hallucinate(changes)
    end
  end

  sig { returns T::Array[String] }
  def changes
    account.commits.where(id: commits).pluck(:message)
  end
end
