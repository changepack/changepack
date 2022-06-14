# frozen_string_literal: true

module Adapters
  class GitHub < Adapter
    def repositories
      client.repos.map do |repo|
        Hashie::Mash.new(
          id: repo.id,
          name: repo.full_name,
          branch: repo.default_branch
        )
      end
    end

    private

    def client
      @client ||= Octokit::Client.new(access_token:).tap { |c| c.auto_paginate = true }
    end
  end
end
