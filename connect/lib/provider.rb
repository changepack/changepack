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

  Results = T.type_alias { T::Array[Hash] }

  attribute :access_token, T.instance(AccessToken)

  abstract!

  sig { params(provider: T::Key).returns(T.untyped) }
  def self.[](provider)
    to_h.fetch(provider.to_sym)
  end

  sig { returns T::Hash[Symbol, Class] }
  def self.to_h
    {
      github: GitHub,
      linear: Linear
    }
  end

  sig { returns T::Array[String] }
  def self.to_a
    to_h.keys
  end

  sig { abstract.returns Results }
  def repositories; end

  sig { abstract.params(_repository_id: T.untyped).returns(Results) }
  def commits(_repository_id); end

  sig { abstract.returns Results }
  def teams; end

  sig { abstract.params(_team_id: T.untyped).returns(Results) }
  def issues(_team_id); end

  sig { returns Symbol }
  def provider
    self.class.name.demodulize.downcase.to_sym
  end

  private

  sig { abstract.returns T.untyped }
  def client; end
end
