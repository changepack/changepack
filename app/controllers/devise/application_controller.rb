# frozen_string_literal: true

module Devise
  class ApplicationController < ApplicationController
    skip_verify_authorized
  end
end
