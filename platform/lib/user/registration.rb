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
      def register!(provider, auth)
        transaction do
          user = case provider.to_sym
                 when :github
                   register_github!(auth)
                 end

          user.tap { |usr| usr.register_access_token!(provider, auth:) }
        end
      end

      sig { params(auth: OmniAuth::AuthHash).returns(User) }
      def register_github!(auth)
        where.contains(providers: { github: auth.uid }).first_or_create! do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.providers = { github: { id: auth.uid } }
        end
      end
    end
  end

  sig { params(provider: T::Key, auth: OmniAuth::AuthHash).returns(User) }
  def register!(provider, auth)
    User.transaction do
      lock!
      update! providers: providers.deep_merge(provider => auth.uid)
      register_access_token!(provider, auth:)
    end

    self
  end

  sig { params(provider: T::Key, auth: OmniAuth::AuthHash).returns(AccessToken) }
  def register_access_token!(provider, auth:)
    AccessToken.find_or_create_by!(
      token: auth.credentials.token,
      user: self,
      provider:,
      account:
    )
  end
end
