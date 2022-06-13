# frozen_string_literal: true

module Repositories
  class Pull < Command
    Disconnected = Class.new(Command::Error)

    option :user, model: User

    def validate
      raise Disconnected unless user.git?
    end

    def perform
      git.repos.each { |r| upsert_repository!(r) }
    end

    private

    def upsert_repository!(repository)
      Repository.find_or_initialize_by(account:, provider: git.provider, provider_id: repository.id) do |r|
        r.update!(
          name: repository.name,
          branch: repository.branch,
          user:
        )
      end
    end

    def git
      @git ||= Adapters::Adapter.find_by(user:)
    end

    delegate :account, to: :user
  end
end
