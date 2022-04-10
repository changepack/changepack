# frozen_string_literal: true

module Repositories
  module Github
    class Pull < Command
      Disconnected = Class.new(Command::Error)

      params user: Types::Instance(User)

      def validate!
        raise Disconnected if user.github_access_token.nil?
      end

      def perform
        client.repos.each { |r| upsert_repository!(r) }
      end

      private

      def upsert_repository!(repository)
        Repository.find_or_initialize_by(provider: :github, provider_id: repository.id) do |r|
          r.update!(
            user:,
            account: user.account,
            name: repository.full_name,
            default_branch: repository.default_branch,
            provider: :github,
            provider_id: repository.id
          )
        end
      end

      def client
        @client ||= Octokit::Client.new(access_token: user.github_access_token)
      end

      delegate :user, to: :params
    end
  end
end
