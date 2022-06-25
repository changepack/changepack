# frozen_string_literal: true

module Adapters
  class GitHub < Adapter
    def repositories
      paginate { client.repos }.map do |repo|
        Repository.new(
          id: repo.id,
          name: repo.full_name,
          branch: repo.default_branch
        )
      end
    end

    def commits(repository_id, after: nil) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      paginate(after:) { client.commits(repository_id.to_i) }.map do |commit|
        Commit.new(
          sha: commit.sha,
          message: commit.commit.message,
          url: commit.commit.url,
          commited: commit.commit.author.date,
          author: {
            name: commit.commit.author.name,
            email: commit.commit.author.email
          }
        )
      end
    end

    private

    def paginate(items: [], after: nil)
      items += yield
      next_page = client.last_response.rels[:next]&.href
      ids = items.map(&:sha)

      return items if next_page.nil? || after.in?(ids)

      paginate(items:, after:) { client.get(next_page) }
    end

    def client
      @client ||= Octokit::Client.new(access_token:).tap { |c| c.per_page = 100 }
    end
  end
end
