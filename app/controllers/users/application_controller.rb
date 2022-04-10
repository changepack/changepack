# frozen_string_literal: true

module Users
  class ApplicationController < ApplicationController
    skip_verify_authorized
  end
end
