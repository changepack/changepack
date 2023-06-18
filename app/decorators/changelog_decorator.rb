# typed: false
# frozen_string_literal: true

class ChangelogDecorator < ApplicationDecorator
  sig { returns T::Array[T::Array[String]] }
  def privacies
    Changelog::PRIVACY.map { |privacy| [privacy.humanize, privacy] }
  end
end