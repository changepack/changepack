# frozen_string_literal: true

module Adapters
  class Adapter
    extend T::Sig

    def initialize(access_token)
      @access_token = access_token
    end

    attr_reader :access_token

    def repositories
      raise 'Not implemented'
    end

    def commits(_repository_id)
      raise 'Not implemented'
    end

    def provider
      self.class.name.demodulize.downcase.to_sym
    end

    private

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
