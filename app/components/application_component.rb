# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  extend Dry::Initializer
  include Pagy::Backend

  delegate :current_user, :current_account, :user_signed_in?, :allowed_to?, :icon, to: :helpers
end
