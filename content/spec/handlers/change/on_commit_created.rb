# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Change
  describe OnCommitCreated do
    let(:user) { create(:user) }
    let(:commit) { create(:commit) }
    let(:payload) do
      {
        event_type: 'Commit::Created',
        data: {
          account_id: user.account_id,
          message: commit.message,
          id: commit.id
        }
      }
    end

    subject(:handler) { described_class.new }

    it 'creates a change for the commit' do
      expect { handler.perform(payload) }.to change(Change, :count).by(1)
    end

    context 'with attributes' do
      subject(:change) { Change.last }
      before { handler.perform(payload) }

      it { expect(change.type).to eq 'commit' }
      it { expect(change.account_id).to eq user.account_id }
      it { expect(change.commit_id).to eq commit.id }
      it { expect(change.message).to eq commit.message }
    end
  end
end
