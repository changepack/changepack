# typed: false
# frozen_string_literal: true

class Summary
  include Events

  include ActiveModel::Model
  include ActiveModel::Attributes

  include AfterCommitEverywhere

  extend T::Sig

  PERIOD = 4.weeks
  ENOUGH = 100

  attribute :changelog, T.instance(Changelog)

  sig { returns T::Boolean }
  def save
    return false if updates.blank?

    publication.save
    after_commit { notify if post.valid? }

    true
  end

  def notify
    SummaryMailer.with(post:).notify
  end

  private

  delegate :account, to: :changelog
  delegate :post, to: :publication

  sig { returns Publication }
  def publication
    @publication ||= Publication.new(
      account: changelog.account,
      updates:,
      title:,
      post:
    )
  end

  sig { returns T::Array[T::String] }
  def updates
    @updates ||= collection.then { |base| Sydney.new(account:).choose(base) }
                           .then { |choices| choices.scan(/upd_\w+/) }
                           .then { |id| Update.where(id:).pluck(:id) }
  end

  sig { returns Update::RelationType }
  def collection
    @collection ||= changelog.updates
                             .where(post: nil)
                             .where(created_at: PERIOD.ago..)
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
