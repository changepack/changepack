# typed: false
# frozen_string_literal: true

class Publication
  include ActiveModel::Model
  include ActiveModel::Attributes

  extend T::Sig

  attribute :title, :string
  attribute :content, :string
  attribute :published, :boolean, default: false
  attribute :updates, array: true, default: -> { [] }
  attribute :post, T.instance(Post)
  attribute :account, T.instance(Account)
  attribute :user, T.instance(User)

  sig { returns T::Boolean }
  def update!
    Post.transaction do
      post.update(content: completion, title:, account:, user:, changelog:)
      post.publish(published)
      post.detach(except: updates)
      post.attach(updates)
    end

    true
  end

  alias create! update!

  private

  sig { returns T.nilable(String) }
  def completion
    if content.present? || updates.none?
      content
    else
      Sydney.new(account:).hallucinate(changes)
    end
  end

  sig { returns T::Array[String] }
  def changes
    account.updates.where(id: updates).pluck(:name)
  end

  sig { returns Changelog }
  def changelog
    @changelog ||= account.changelogs.first!
  end
end