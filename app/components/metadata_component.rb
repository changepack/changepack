# frozen_string_literal: true

class MetadataComponent < ApplicationComponent
  option :changelog

  private

  def user
    @user ||= changelog.user || (
      helpers.current_user if changelog.new_record?
    )
  end

  def user?
    user.present?
  end

  def draft?
    changelog.status.draft? && !changelog.new_record?
  end

  def published_on
    @published_on ||= changelog.created_at || Time.current
  end
end
