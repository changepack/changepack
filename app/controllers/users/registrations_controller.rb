# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    private

    def sign_up_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmations
      )
    end

    def account_update_params
      params.require(:user).permit(
        :email,
        :name,
        :password,
        :password_confirmation,
        :current_password,
        account_attributes: %i[id name description website]
      )
    end
  end
end
