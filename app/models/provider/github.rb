# frozen_string_literal: true

class Provider
  class GitHub < Provider
    def repositories(after: nil)
      paginate(after:) { client.repos }.map { |repo| Repository.map(repo) }
    end

    def commits(repository_id, after: nil)
      paginate(after:) { client.commits(repository_id.to_i) }.map { |commit| Commit.map(commit) }
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

    class Repository < Provider::Repository
      def self.map(repository)
        new(
          id: repository.id,
          name: repository.full_name,
          branch: repository.default_branch
        )
      end
    end

    class Commit < Provider::Commit
      def self.map(commit)
        new(
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
  end
end
