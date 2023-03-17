# frozen_string_literal: true

class Provider
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :access_token, :string
  attribute :account_id, :string

  def repositories
    raise NoMethodError
  end

  def commits(_repository_id)
    raise NoMethodError
  end

  def provider
    self.class.name.demodulize.downcase.to_sym
  end

  def self.[](provider)
    providers.fetch(provider.to_sym)
  end

  def self.providers
    {
      github: GitHub
    }
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

    def self.map(_source)
      raise NoMethodError
    end
  end

  class Commit < Dry::Struct
    attribute :sha, Types::String
    attribute :message, Types::String
    attribute :url, Types::String
    attribute :commited_at, Types::Time
    attribute :author do
      attribute :name, Types::String
      attribute :email, Types::String
    end

    def to_h
      {
        message:,
        url:,
        commited_at:,
        author: { name: author.name, email: author.email }
      }
    end

    def self.map(_source)
      raise NoMethodError
    end
  end
end
