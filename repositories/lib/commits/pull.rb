# frozen_string_literal: true

module Commits
  class Pull < Command
    Disconnected = Class.new(Command::Error)

    option :repository, model: Repository

    validate do
      raise Disconnected unless user.git?
    end

    def execute
      git.commits(repository.provider_id, after: cursor).each { |commit| upsert!(commit) }
    end

    private

    def git
      @git ||= Adapters::Adapter.find_by(user:)
    end

    def cursor
      @cursor ||= repository.commits
                            .where('commited_at > ?', 1.month.ago)
                            .order(commited_at: :desc)
                            .limit(1)
                            .pick(:commited_at)
    end

    def upsert!(commit)
      Commit.find_or_initialize_by(repository:, provider: git.provider, provider_id: commit.sha) do |c|
        c.update!(
          message: commit.message,
          url: commit.url,
          commited_at: commit.commited,
          author: { name: commit.author.name, email: commit.author.email },
          account:
        )
      end
    end

    delegate :user, :account, to: :repository
  end
end
