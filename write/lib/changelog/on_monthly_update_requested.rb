# typed: false
# frozen_string_literal: true

class Changelog
  class OnMonthlyUpdateRequested < Handler
    on ::Changelog::MonthlyUpdateRequested

    sig { override.returns T.nilable(Post) }
    def run
      Post.hallucinate(changelog)
    end

    sig { returns Changelog }
    def changelog
      Changelog.find(event.changelog_id)
    end
  end
end
