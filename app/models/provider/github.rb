# typed: false
# frozen_string_literal: true

class Provider
  class GitHub < Provider
    Results = T.type_alias { T.any(Provider::Repository, Provider::Commit).array }
    Cursor = T.type_alias { T::Integer.nilable }

    sig { override.params(after: Cursor).returns(Provider::Repository.array) }
    def repositories(after: nil)
      repositories = paginate(after:) { client.repos }
      repositories.map { |repo| Mapper.repository(repo) }
    end

    sig { override.params(repository_id: T::Integer, after: Cursor).returns(Provider::Commit.array) }
    def commits(repository_id, after: nil)
      commits = paginate(after:) { client.commits(repository_id) }
      commits.map { |commit| Mapper.commit(commit) }
    end

    private

    sig { params(items: Results, after: Cursor).returns(Results) }
    def paginate(items: [], after: nil)
      new_items = yield
      paginated_items = items.concat(new_items)

      if exhausted?(paginated_items, after:)
        items
      else
        paginate(items: paginated_items, after:) { client.get(next_page) }
      end
    end

    sig { params(items: Results, after: Cursor).returns(T::Boolean) }
    def exhausted?(items, after:)
      next_page.blank? || items.map(&:sha).include?(after)
    end

    sig { returns T::String.nilable }
    def next_page
      client.last_response
            .rels
            .fetch(:next, nil)
            .try(:href)
    end

    sig { override.returns(Octokit::Client) }
    def client
      @client ||= Octokit::Client.new(access_token:, per_page: 100)
    end

    class Mapper
      extend T::Sig

      sig { params(repository: Sawyer::Resource).returns(Provider::Repository) }
      def self.repository(repository)
        Provider::Repository.new(
          id: repository.id,
          name: repository.full_name,
          branch: repository.default_branch
        )
      end

      sig { params(commit: Sawyer::Resource).returns(Provider::Commit) }
      def self.commit(commit)
        Provider::Commit.new(
          sha: commit.sha,
          message: commit.commit.message,
          url: commit.html_url,
          commited_at: commit.commit.author.date,
          author: Provider::Commit::Author.new(
            name: commit.commit.author.name,
            email: commit.commit.author.email
          )
        )
      end
    end
  end
end
