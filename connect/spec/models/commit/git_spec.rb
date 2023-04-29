# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Commit
  describe Git, :vcr do
    subject(:command) { Commit.pull(repository) }
    let(:repository) { create(:repository, providers:, access_token:) }

    context 'with a GitHub integration' do
      let(:providers) { { github: { id: 1 } } }
      let!(:access_token) { create(:access_token) }

      it 'upserts repositories' do
        expect { command }.to change(repository.commits, :count)
      end
    end
  end
end
