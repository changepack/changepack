# frozen_string_literal: true

class User
  module Registration
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable, :rememberable, :validatable, :registerable, :omniauthable,
             omniauth_providers: [:github]

      after_initialize do
        self.account ||= Account.new if account.nil?
      end
    end

    class_methods do
      def from!(provider, auth)
        case provider.to_sym
        when :github
          from_github!(auth)
        end
      end

      def from_github!(auth)
        where.contains(providers: { github: { id: auth.uid } }).first_or_create! do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.providers = provider(:github, auth)
        end
      end

      def provider(provider, auth)
        case provider.to_sym
        when :github
          {
            github: { id: auth.uid, access_token: auth.credentials.token }
          }
        end
      end
    end
  end
end