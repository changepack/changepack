# typed: false
# frozen_string_literal: true

class ChangelogPolicy < ApplicationPolicy
  alias_rule :edit?, :destroy?, to: :update?
  alias_rule :new?, to: :create?

  params_filter do |params|
    params.permit(:name, :privacy)
  end

  def index?
    user.present?
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    check?(:create?) && user.account_id == record.account_id
  end
end
