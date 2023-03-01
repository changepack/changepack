# frozen_string_literal: true

class MetadataComponent < LegacyApplicationComponent
  option :changelog, Types::Instance(Changelog)

  def user
    @user ||= changelog.user || new_user
  end

  def user?
    user.present?
  end

  def published
    @published ||= (changelog.created || Time.current).to_date
  end

  private

  def new_user
    helpers.current_user if changelog.new_record?
  end
end
