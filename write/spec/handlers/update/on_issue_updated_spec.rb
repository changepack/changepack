# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
  describe OnIssueUpdated do
    let(:update) { create(:update, :issue) }
    let(:payload) do
      {
        event_type: 'Issue::Updated',
        data: Issue::Resource.to_event(update.issue)
      }
    end

    subject(:handler) { described_class.new }

    before do
      update.issue.update!(done: true)
      update.discard!
    end

    def perform
      handler.perform(payload)
    end

    def discarded?
      update.reload.discarded?
    end

    it 'undiscards the update' do
      expect { perform }.to change { discarded? }.from(true).to(false)
    end
  end
end
