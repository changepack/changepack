# frozen_string_literal: true

module Repositories
  module GitHub
    class Pull < Command
      Disconnected = Class.new(Command::Error)

      option :user, model: User

      def validate!
        raise Disconnected if user.github_access_token.nil?
      end

      def perform
        validate!

        client.repos.each { |r| upsert_repository!(r) }
      end

      private

      def upsert_repository!(repository)
        Repository.find_or_initialize_by(account:, provider: :github, provider_id: repository.id) do |r|
          r.update!(
            name: repository.full_name,
            branch: repository.default_branch,
            user:
          )
        end
      end

      def client
        @client ||= Octokit::Client.new(access_token: user.github_access_token).tap do |client|
          client.auto_paginate = true
        end
      end

      delegate :account, to: :user
    end
  end
end
