# frozen_string_literal: true

module Commits
  module GitHub
    class Pull < Command
      Disconnected = Class.new(Command::Error)
      NotGitHub = Class.new(Command::Error)

      option :repository, model: Repository

      def validate!
        raise Disconnected if user.github_access_token.nil?
        raise NotGitHub unless repository.provider.github?
      end

      def perform
        client.commits(repository.provider_id).each { |c| upsert_commit!(c) }

        paginate!
      end

      private

      def paginate!
        return if next_page.nil?

        commits = client.get(next_page)
                        .tap { |c| upsert_commit!(c) }

        return if repository.commits
                            .github
                            .where(provider_id: commits.map(&:sha))
                            .any?

        paginate!
      end

      def upsert_commit!(record)
        Commit.find_or_initialize_by(repository:, provider: :github, provider_id: record.sha) do |c|
          c.update!(
            message: record.commit.message,
            url: record.commit.url,
            commited_at: record.commit.author.date,
            author: { name: record.commit.name, email: record.commit.email },
            account:
          )
        end
      end

      def next_page
        client.last_response.rels[:next]&.href
      end

      def client
        @client ||= Octokit::Client.new(access_token: user.github_access_token)
      end

      delegate :user, :account, to: :repository
    end
  end
end
