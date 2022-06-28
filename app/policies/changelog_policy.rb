# frozen_string_literal: true

class ChangelogPolicy < ApplicationPolicy
  alias_rule :edit?, :confirm_destroy?, :destroy?, to: :update?
  alias_rule :index?, to: :show?
  alias_rule :new?, to: :create?

  params_filter do |params|
    params.permit(:title, :content, :published, commit_ids: [])
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
