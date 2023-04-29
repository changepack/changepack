# typed: false
# frozen_string_literal: true

module T
  Provider = T.type_alias { ::Provider }
  Providers = T.type_alias { Array[::Provider] }
end

class Provider
  extend T::Helpers
  extend T::Sig

  include ActiveModel::Model
  include ActiveModel::Attributes

  Result = T.type_alias { T.any(Provider::Repository, Provider::Commit) }
  Results = T.type_alias { T::Array[Result] }

  attribute :access_token, T.instance(AccessToken)
  attribute :account_id, :string

  abstract!

  sig { params(provider: T::Key).returns(T.untyped) }
  def self.[](provider)
    to_h.fetch(provider.to_sym)
  end

  sig { returns T::Hash[Symbol, Class] }
  def self.to_h
    {
      github: GitHub
    }
  end

  sig { returns T::Array[String] }
  def self.to_a
    to_h.keys
  end

  sig { returns T::Shape }
  def self.to_shapes
    # TODO: Uncomment once we add more providers
    # T.any(
    #   { github: { id: String, access_token: String } },
    #   { ... }
    # )

    { github: { id: String, access_token: String } }
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
    attribute :id, Integer
    attribute :name, String
    attribute :branch, String

    sig { returns(name: String, branch: String) }
    def to_h
      { name:, branch: }
    end
  end

  class Commit < T::Struct
    class Author < T::Struct
      attribute :name, String
      attribute :email, String

      sig { returns T::Shape }
      def self.to_shape
        { name: String, email: String }
      end
    end

    attribute :sha, String
    attribute :message, String
    attribute :url, String
    attribute :commited_at, T::Time
    attribute :author, Author

    sig { returns T::Shape }
    def self.to_shape
      { message: String, url: String, commited_at: T::Time, author: Author.to_shape }
    end

    sig { returns Commit.to_shape }
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
