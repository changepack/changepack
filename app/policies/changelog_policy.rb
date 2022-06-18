# frozen_string_literal: true

class ChangelogPolicy < ApplicationPolicy
  alias_rule :edit?, :update?, :confirm_destroy?, :destroy?, to: :manage?
  alias_rule :index?, to: :show?
  alias_rule :new?, to: :create?

  def show?
    true
  end

  def create?
    user.present?
  end

  def manage?
    return false if user.nil? || record.nil? || record_is_class?

    user.account_id == record.account_id
  end
end
