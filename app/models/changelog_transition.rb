# frozen_string_literal: true

class ChangelogTransition < ApplicationRecord
  key :ctr

  belongs_to :changelog, inverse_of: :transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = changelog.transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update!(:most_recent, true)
  end
end
