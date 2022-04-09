# frozen_string_literal: true

class ChangelogComponent < ApplicationComponent
  option :changelog
  option :readonly, optional: true, default: -> { false }
end
