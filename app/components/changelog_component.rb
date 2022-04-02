# frozen_string_literal: true

class ChangelogComponent < ViewComponent::Base
  def initialize(changelog:)
    @changelog = changelog

    super
  end

  attr_reader :changelog
end
