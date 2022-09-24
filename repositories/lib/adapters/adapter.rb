# frozen_string_literal: true
# typed: strict

module Adapters
  class Adapter
    extend T::Sig

    sig { params(access_token: String).void }
    def initialize(access_token)
      @access_token = T.let(access_token, T.untyped)
    end

    sig { returns(String) }
    attr_reader :access_token

    sig { params(after: T.nilable(String)).returns(T::Array[Repository]) }
    def repositories(after: nil) # rubocop:disable Lint/UnusedMethodArgument
      raise 'Not implemented'
    end

    sig { params(repository: String, after: T.nilable(String)).returns(T::Array[Commit]) }
    def commits(repository, after: nil) # rubocop:disable Lint/UnusedMethodArgument
      raise 'Not implemented'
    end

    sig { returns(Symbol) }
    def provider
      T.must(self.class.name).demodulize.downcase.to_sym
    end

    private

    sig { returns(Octokit::Client) }
    def client
      raise 'Not implemented'
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
      attribute :commited, Types::Time
      attribute :author do
        attribute :name, Types::String
        attribute :email, Types::String
      end
    end
  end
end
