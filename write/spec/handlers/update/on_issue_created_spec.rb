# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
  describe OnIssueCreated do
    let(:issue) { create(:issue) }
    let(:payload) do
      {
        event_type: 'Issue::Created',
        data: Issue::Resource.to_event(issue)
      }
    end

    subject(:handler) { described_class.new }
    before { create(:source, team: issue.team) }

    it 'creates an update for the issue' do
      expect { handler.perform(payload) }.to change(Update, :count).by(1)
    end

    context 'with attributes' do
      subject(:update) { Update.last }
      before { handler.perform(payload) }

      specify { expect(update.type).to eq 'issue' }
      specify { expect(update.account_id).to eq issue.account_id }
      specify { expect(update.issue_id).to eq issue.id }
      specify { expect(update.name).to eq issue.title }
    end
  end
end
