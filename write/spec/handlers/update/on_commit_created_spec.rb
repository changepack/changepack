# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
  describe OnCommitCreated do
    let(:commit) { create(:commit) }
    let(:payload) do
      {
        event_type: 'Commit::Created',
        data: Commit::Resource.to_event(commit)
      }
    end

    subject(:handler) { described_class.new }
    before { create(:source, repository: commit.repository) }

    it 'creates an update for the commit' do
      expect { handler.perform(payload) }.to change(Update, :count).by(1)
    end

    context 'with attributes' do
      subject(:update) { Update.last }
      before { handler.perform(payload) }

      specify { expect(update.type).to eq 'commit' }
      specify { expect(update.account_id).to eq commit.account_id }
      specify { expect(update.commit_id).to eq commit.id }
      specify { expect(update.name).to eq commit.message }
    end
  end
end
