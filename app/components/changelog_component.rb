# frozen_string_literal: true

class ChangelogComponent < LegacyApplicationComponent
  option :changelog, Types::Instance(Changelog)

  def draft?
    changelog.status.draft? && !changelog.new_record?
  end
end
