# frozen_string_literal: true

class Publication
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :content, :string
  attribute :published, :boolean
  attribute :commits, array: true, default: -> { [] }
  attribute :changelog
  attribute :account
  attribute :user

  def update!
    Changelog.transaction do
      changelog.update(title:, content:, account:, user:)
      changelog.publish(published)
      changelog.detach(except: commits)
      changelog.attach(commits)
    end
  end

  alias create! update!
end
