# frozen_string_literal: true

class MetadataComponent < ApplicationComponent
  option :changelog, model: Changelog

  def user
    @user ||= changelog.user || new_user
  end

  def user?
    user.present?
  end

  def draft?
    changelog.status.draft? && !changelog.new_record?
  end

  def published
    @published ||= (changelog.created || Time.current).to_date
  end

  private

  def new_user
    helpers.current_user if changelog.new_record?
  end
end
