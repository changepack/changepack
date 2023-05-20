# typed: false
# frozen_string_literal: true

module I
  class Update < ApplicationComponent
    attribute :update, T::Update
    attribute :post, T.nilable(::Post)

    delegate :commit, :issue, to: :update

    def template
      case update.type
      when 'commit'
        render I::Commit.new(commit:, url:)
      when 'issue'
        render I::Issue.new(issue:, url:)
      end
    end

    def url
      helpers.scoped_post_path(update.post) if update.disabled?(post)
    end
  end
end
