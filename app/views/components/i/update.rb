# typed: false
# frozen_string_literal: true

module I
  class Update < ApplicationComponent
    attribute :update, T::Update
    attribute :post, T.nilable(::Post)

    delegate :commit, to: :update

    def template
      case update.type
      when 'commit'
        render I::Commit.new(commit:, url:)
      end
    end

    def url
      helpers.post_path(update.post) if update.disabled?(post)
    end
  end
end
