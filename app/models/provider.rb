# typed: false
# frozen_string_literal: true

class Provider
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::T

  attribute :access_token, :string
  attribute :account_id, :string

  sig { returns(Symbol) }
  def provider
    self.class.name.demodulize.downcase.to_sym
  end

  sig { params(provider: T::String | T::Symbol).returns(T.untyped) }
  def self.[](provider)
    providers.fetch(provider.to_sym)
  end

  sig { returns T::Hash[Symbol, Class] }
  def self.providers
    {
      github: GitHub
    }
  end

  def repositories
    raise NoMethodError
  end

  def commits(_repository_id)
    raise NoMethodError
  end

  private

  def client
    raise NoMethodError
  end

  class Repository < Dry::Struct
    attribute :id, Types::Integer
    attribute :name, Types::String
    attribute :branch, Types::String

    sig { returns T::Hash[Symbol, String] }
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

    sig { returns T::Hash[T::Symbol, T.any(T::String, T::Hash[Symbol, String], T::Time)] }
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
