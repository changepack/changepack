# frozen_string_literal: true

class ChangelogComponent < ApplicationComponent
  option :changelog, model: Changelog

  def draft?
    changelog.status.draft? && !changelog.new_record?
  end
end
