# frozen_string_literal: true

class ChangelogComponent < ViewComponent::Base
  def initialize(changelog:)
    @changelog = changelog
  end

  attr_reader :changelog
end
