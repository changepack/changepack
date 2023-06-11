# typed: false
# frozen_string_literal: true

class ChangelogPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
