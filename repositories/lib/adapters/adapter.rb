# frozen_string_literal: true

module Adapters
  class Adapter
    NotImplemented = Class.new(StandardError)

    def initialize(access_token)
      @access_token = access_token
    end

    attr_reader :access_token

    def repositories
      raise NotImplemented
    end

    def commits(_repository_id)
      raise NotImplemented
    end

    def provider
      self.class.name.demodulize.downcase.to_sym
    end

    def self.find_by(user:)
      providers.keys
               .find { |provider| provider.to_s.in?(user.provider_ids.keys) }
               .then { |provider| providers.fetch(provider).new(user.access_token(provider)) }
    end

    def self.providers
      {
        github: Adapters::GitHub
      }
    end

    private

    def client
      raise 'Not implemented yet!'
    end

    class Repository < Dry::Struct
      attribute :id, Types::Integer
      attribute :name, Types::String
      attribute :branch, Types::String
    end

    class Commit < Dry::Struct
      attribute :sha, Types::String
      attribute :message, Types::String
      attribute :url, Types::String
      attribute :commited, Types::Date
      attribute :author do
        attribute :name, Types::String
        attribute :email, Types::String
      end
    end
  end
end
