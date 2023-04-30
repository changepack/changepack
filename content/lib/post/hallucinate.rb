# typed: false
# frozen_string_literal: true

class Post
  module Hallucinate
    extend ActiveSupport::Concern
    extend T::Sig

    PERIOD = 2.weeks
    ENOUGH = 10

    class_methods do
      extend T::Sig

      sig { params(changelog: Changelog).returns T.nilable(Post) }
      def hallucinate(changelog)
        updates = changelog.updates
                           .where(post: nil)
                           .where(created_at: PERIOD.ago..)
                           .limit(ENOUGH)
                           .pluck(:id)

        return if updates.empty?

        new(changelog:).tap do |post|
          Publication.new(updates:, post:, account: changelog.account).update!
        end
      end
    end
  end
end
