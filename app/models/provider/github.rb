# frozen_string_literal: true

class Provider
  class GitHub < Provider
    def repositories(after: nil)
      repositories = paginate(after:) { client.repos }
      repositories.map { |repo| Repository.map(repo) }
    end

    def commits(repository_id, after: nil)
      commits = paginate(after:) { client.commits(repository_id.to_i) }
      commits.map { |commit| Commit.map(commit) }
    end

    private

    def paginate(items: [], after: nil)
      new_items = yield
      paginated_items = items.concat(new_items)

      if exhausted?(paginated_items, after:)
        items
      else
        paginate(items: paginated_items, after:) { client.get(next_page) }
      end
    end

    def exhausted?(items, after:)
      next_page.blank? || items.map(&:sha).include?(after)
    end

    def next_page
      client.last_response
            .rels
            .fetch(:next, nil)
            .try(:href)
    end

    def client
      @client ||= Octokit::Client.new(access_token:, per_page: 100)
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
