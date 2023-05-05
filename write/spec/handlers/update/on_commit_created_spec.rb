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
          repository_id: commit.repository_id,
          author: commit.author.as_json,
          account_id: user.account_id,
          message: commit.message,
          id: commit.id
        }
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
      specify { expect(update.account_id).to eq user.account_id }
      specify { expect(update.commit_id).to eq commit.id }
      specify { expect(update.name).to eq commit.message }
    end
  end
end
