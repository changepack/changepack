# typed: false
# frozen_string_literal: true

class Post
  module Hallucinate
    extend ActiveSupport::Concern
    extend T::Sig

    PERIOD = 4.weeks
    ENOUGH = 100

    class_methods do
      extend T::Sig

      sig { params(changelog: Changelog).returns T.nilable(Post) }
      def hallucinate(changelog)
        updates = Post::Hallucinate.choose(from: changelog)
        return if updates.blank?

        new(changelog:).tap do |post|
          Publication.new(
            account: changelog.account,
            updates:,
            post:
          ).update!
        end
      end
    end

    sig { params(changelog: Changelog).returns T::Updates }
    def self.updates(changelog)
      changelog.updates
               .where(post: nil)
               .where(created_at: PERIOD.ago..)
               .limit(ENOUGH)
    end

    sig { params(from: Changelog).returns T::Array[T::String] }
    def self.choose(from:)
      base = Post::Hallucinate.updates(from)
      return [] if base.blank?

      choices = Sydney.new(account: from.account).choose(base)
      return [] if choices.blank?

      Update.where(id: choices.scan(/upd_\w+/)).pluck(:id)
    end
  end
end
