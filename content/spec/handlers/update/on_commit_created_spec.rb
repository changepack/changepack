# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
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

    it 'creates an update for the commit' do
      expect { handler.perform(payload) }.to change(Update, :count).by(1)
    end

    context 'with attributes' do
      subject(:update) { Update.last }
      before { handler.perform(payload) }

      it { expect(update.type).to eq 'commit' }
      it { expect(update.account_id).to eq user.account_id }
      it { expect(update.commit_id).to eq commit.id }
      it { expect(update.name).to eq commit.message }
    end
  end
end
