# typed: false
# frozen_string_literal: true

class User
  module Registration
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    abstract!

    included do
      devise :database_authenticatable, :rememberable, :validatable, :registerable, :omniauthable,
             omniauth_providers: %i[github linear]

      before_save do
        self.account ||= Account.new
      end
    end

    class_methods do
      extend T::Sig

      sig { overridable.params(provider: T::Key, auth: OmniAuth::AuthHash).returns(User) }
      def register!(provider, auth)
        transaction do
          User::Registration
            .first_or_create!(provider, auth)
            .tap { |user| user.register_access_token!(provider, auth:) }
        end
      end
    end
  end

  sig { overridable.params(proviser: T::Key, auth: OmniAuth::AuthHash).returns(User) }
  def self.first_or_create!(provider, auth)
    User.where.contains(providers: { provider => auth.uid }).first_or_create! do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.providers = { provider => auth.uid }
    end
  end

  sig { overridable.params(provider: T::Key, auth: OmniAuth::AuthHash).returns(User) }
  def register!(provider, auth)
    User.transaction do
      lock!
      update! providers: providers.deep_merge(provider => auth.uid)
      register_access_token!(provider, auth:)
    end

    self
  end

  sig { overridable.params(provider: T::Key, auth: OmniAuth::AuthHash).returns(AccessToken) }
  def register_access_token!(provider, auth:)
    AccessToken.find_or_create_by!(
      token: auth.credentials.token,
      user: self,
      provider:,
      account:
    )
  end
end
