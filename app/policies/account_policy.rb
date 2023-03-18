# typed: false
# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
