# typed: false
# frozen_string_literal: true

class Provider
  class GitHub < Provider
    Cursor = T.type_alias { T.nilable(Integer) }

    sig { override.params(after: Cursor).returns(Results) }
    def repositories(after: nil)
      repositories = paginate(after:) { client.repos }
      repositories.map { |repo| Mapper.repository(repo) }
    end

    sig { override.params(repository_id: Integer, after: Cursor).returns(Results) }
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

    sig { returns T.nilable(String) }
    def next_page
      client.last_response
            .rels
            .fetch(:next, nil)
            .try(:href)
    end

    sig { override.returns(Octokit::Client) }
    def client
      @client ||= Octokit::Client.new(
        access_token: access_token.to_s,
        per_page: 100
      )
    end

    class Mapper
      extend T::Sig

      sig { params(repository: Sawyer::Resource).returns(Hash) }
      def self.repository(repository)
        {
          name: repository.full_name,
          branch: repository.default_branch,
          providers: { github: repository.id }
        }
      end

      sig { params(commit: Sawyer::Resource).returns(Hash) }
      def self.commit(commit)
        {
          message: commit.commit.message,
          url: commit.html_url,
          commited_at: commit.commit.author.date,
          providers: { github: commit.sha },
          author: {
            name: commit.commit.author.name,
            email: commit.commit.author.email
          }
        }
      end
    end
  end
end
