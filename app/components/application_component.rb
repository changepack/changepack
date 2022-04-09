# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  extend Dry::Initializer
  include Pagy::Backend

  delegate :current_user, :allowed_to?, :icon, to: :helpers
end
