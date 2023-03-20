# typed: false
# frozen_string_literal: true

class Provider
  extend T::Helpers

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::T

  abstract!

  attribute :access_token, :string
  attribute :account_id, :string

  Result = T.type_alias { T.any(Provider::Repository, Provider::Commit) }
  Results = T.type_alias { T::Array[Result] }

  sig { params(provider: T::Key).returns(T.untyped) }
  def self.[](provider)
    providers.fetch(provider.to_sym)
  end

  sig { returns T::Hash[Symbol, Class] }
  def self.providers
    {
      github: GitHub
    }
  end

  sig { abstract.returns Results }
  def repositories; end

  sig { abstract.params(_repository_id: T.untyped).returns(Results) }
  def commits(_repository_id); end

  sig { returns Symbol }
  def provider
    self.class.name.demodulize.downcase.to_sym
  end

  private

  sig { abstract.returns T.untyped }
  def client; end

  class Repository < T::Struct
    extend T::Sig

    attribute :id, Integer
    attribute :name, String
    attribute :branch, String

    sig { returns T::Hash[Symbol, String] }
    def to_h
      { name:, branch: }
    end
  end

  class Commit < T::Struct
    extend T::Sig

    class Author < T::Struct
      attribute :name, String
      attribute :email, String
    end

    attribute :sha, String
    attribute :message, String
    attribute :url, String
    attribute :commited_at, Time
    attribute :author, Author

    sig { returns T::Hash[Symbol, T::String | T::Hash[Symbol, String] | T::Time] }
    def to_h
      {
        message:,
        url:,
        commited_at:,
        author: { name: author.name, email: author.email }
      }
    end
  end
end
