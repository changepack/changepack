# typed: false
# frozen_string_literal: true

class Publication
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  extend T::Sig

  attribute :title, :string
  attribute :content, :string
  attribute :published, :boolean, default: false
  attribute :updates, array: true, default: -> { [] }
  attribute :changelog_id, :string
  attribute :post, T.instance(Post), default: -> { Post.new }
  attribute :account, T.instance(Account)
  attribute :user, T.instance(User)

  validates :account, presence: true

  sig { returns T::Boolean }
  def save
    Post.transaction do
      post.update(**to_post)
      post.publish(published)
      post.detach(except: updates)
      post.attach(updates)
    end

    true
  end

  alias create save
  alias update save

  private

  sig { returns Hash }
  def to_post
    {
      content: completion || content,
      changelog:,
      account:,
      title:,
      user:
    }
  end

  sig { returns T.nilable(String) }
  def completion
    return if content?

    Sydney.new(
      update: account.updates.where(id: updates)
    ).write
  end

  sig { returns T::Boolean }
  def content?
    content.present? || updates.blank?
  end

  sig { returns Changelog }
  def changelog
    @changelog ||= account.changelogs.find_by(id: changelog_id) || account.changelogs.first!
  end
end
