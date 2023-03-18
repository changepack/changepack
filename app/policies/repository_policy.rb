# typed: false
# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  alias_rule :show?, :edit?, :destroy?, to: :update?
  alias_rule :index?, :new?, to: :create?

  relation_scope do |relation|
    relation.where(account_id: user.account_id)
  end

  def create?
    true
  end

  def update?
    user.account_id == record.account_id
  end
end
