# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  alias_rule :new?, :create?, :edit?, :update?, :destroy?, to: :manage?
  alias_rule :index?, to: :show?

  relation_scope do |relation|
    relation.where(account_id: user.account_id)
  end

  def show?
    true
  end

  def manage?
    record_is_class? || user.account_id == record.account_id
  end
end
