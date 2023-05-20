# typed: false
# frozen_string_literal: true

module API
  class ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token, :authenticate_user!
    skip_verify_authorized
  end
end
