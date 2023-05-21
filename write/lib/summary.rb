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

  sig { returns Post }
  def create
    new(changelog:).tap do |post|
      next if updates.blank?

      Publication.new(
        account: changelog.account,
        updates:,
        title:,
        post:
      ).save

      after_commit { SummaryMailer.with(post:).notify if post.valid? }
    end
  end

  private

  delegate :account, to: :changelog

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
  end

  sig { returns String }
  def title
    Date.current
        .last_month
        .strftime('%B %Y')
        .then { |month| I18n.t('summary.title', month:) }
  end
end
