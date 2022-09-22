# frozen_string_literal: true
# typed: true

module Adapters
  class GitHub < Adapter
    sig { params(after: T.nilable(String)).returns(T::Array[Repository]) }
    def repositories(after: nil)
      paginate(after:) { client.repos }.map do |repo|
        Repository.new(
          id: repo.id,
          name: repo.full_name,
          branch: repo.default_branch
        )
      end
    end

    sig { params(repository: String, after: T.nilable(String)).returns(T::Array[Commit]) }
    def commits(repository, after: nil) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      paginate(after:) { client.commits(repository.to_i) }.map do |commit|
        Commit.new(
          sha: commit.sha,
          message: commit.commit.message,
          url: commit.html_url,
          commited: commit.commit.author.date,
          author: {
            name: commit.commit.author.name,
            email: commit.commit.author.email
          }
        )
      end
    end

    private

    sig { params(items: T::Array[T.untyped], after: T.nilable(String)).returns(T::Array[T.untyped]) }
    def paginate(items: [], after: nil)
      items += yield
      next_page = client.last_response.rels[:next]&.href
      ids = items.map(&:sha)

      return items if next_page.nil? || after.in?(ids)

      paginate(items:, after:) { client.get(next_page) }
    end

    sig { returns(Octokit::Client) }
    def client
      @client ||= Octokit::Client.new(access_token:).tap { |c| c.per_page = 100 }
    end
  end
end
