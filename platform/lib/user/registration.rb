# typed: false
# frozen_string_literal: true

class User
  module Registration
    extend ActiveSupport::Concern
    extend T::Sig

    included do
      devise :database_authenticatable, :rememberable, :validatable, :registerable, :omniauthable,
             omniauth_providers: [:github]

      before_save do
        self.account ||= Account.new
      end
    end

    class_methods do
      extend T::Sig

      sig { params(provider: T::Key, auth: OmniAuth::AuthHash).returns(User) }
      def from!(provider, auth)
        transaction do
          user = case provider.to_sym
                 when :github
                   from_github!(auth)
                 end

          user.access_tokens << AccessToken.new(token: auth.credentials.token, provider:)
          user
        end
      end

      sig { params(auth: OmniAuth::AuthHash).returns(User) }
      def from_github!(auth)
        where.contains(providers: { github: auth.uid }).first_or_create! do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.providers = provider(:github, auth)
        end
      end
    end

    sig { params(provider: T::Key, auth: OmniAuth::AuthHash).returns(Provider.to_shapes) }
    def self.provider(provider, auth)
      case provider.to_sym
      when :github
        { github: { id: auth.uid, access_token: auth.credentials.token } }
      end
    end
  end

  sig { params(provider: T::Key, auth: OmniAuth::AuthHash).returns(User) }
  def provide(provider, auth)
    User.transaction do
      lock!
      providers.deep_merge! User::Registration.provider(provider, auth)
      save!

      access_tokens << AccessToken.new(
        token: auth.credentials.token,
        provider:
      )
    end

    self
  end
end
