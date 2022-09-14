# frozen_string_literal: true

module Repositories
  class Pull < Command
    Disconnected = Class.new(Command::Error)

    option :user, Types::Instance(User)

    validate do
      raise Disconnected unless user.git?
    end

    def run
      git.repositories
         .each { |repository| upsert!(repository) }
    end

    private

    def upsert!(repository)
      Repository.find_or_initialize_by(account:, providers: { git.provider => repository.id }) do |r|
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
