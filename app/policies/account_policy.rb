# typed: false
# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  alias_rule :index?, to: :show?

  def show?
    user.present?
  end
end
