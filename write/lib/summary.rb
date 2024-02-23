# typed: false
# frozen_string_literal: true

class Summary
  include Events

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  include AfterCommitEverywhere

  extend T::Sig

  PERIOD = 1.week
  ENOUGH = 100

  attribute :newsletter, T.instance(Newsletter)

  validates :newsletter, presence: true
  validates :updates, presence: true

  delegate :account, to: :newsletter
  delegate :post, to: :publication

  sig { returns T::Boolean }
  def save
    return false if invalid?

    publication.save
    notify if post.valid?

    post.valid?
  end

  sig { returns Notification }
  def notify
    Notification.create!(
      body: post.content.to_s,
      recipient: account,
      category: :write,
      type: :summary
    )
  end

  private

  sig { returns Publication }
  def publication
    @publication ||= Publication.new(
      account: newsletter.account,
      post: Post.new,
      updates:,
      title:
    )
  end

  sig { returns T::Array[T::String] }
  def updates
    return [] if collection.blank?

    @updates ||= collection.then { |update| Sydney.new(update:).choose }
                           .then { |choices| choices.scan(/(upd_\w+)/).flatten }
                           .then { |id| Update.where(id:).pluck(:id) }
  end

  sig { returns Update::RelationType }
  def collection
    return Update.none if newsletter.blank?

    @collection ||= newsletter.updates
                              .where(post: nil)
                              .where(sourced_at: PERIOD.ago..)
                              .limit(ENOUGH)
                              .kept
  end

  sig { returns String }
  def title
    Date.current
        .last_month
        .strftime('%B %Y')
        .then { |month| I18n.t('summary.title', month:) }
  end
end
