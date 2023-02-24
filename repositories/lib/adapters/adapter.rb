# frozen_string_literal: true

module Adapters
  class Adapter
    def initialize(access_token)
      @access_token = access_token
    end

    attr_reader :access_token

    def repositories
      raise NoMethodError
    end

    def commits(_repository_id)
      raise NoMethodError
    end

    def provider
      self.class.name.demodulize.downcase.to_sym
    end

    private

    def client
      raise NoMethodError
    end

    class Repository < Dry::Struct
      attribute :id, Types::Integer
      attribute :name, Types::String
      attribute :branch, Types::String

      def to_h
        { name:, branch: }
      end
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
