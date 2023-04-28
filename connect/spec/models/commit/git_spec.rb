# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Commit
  describe Git, :vcr do
    subject(:command) { Commit.pull(repository) }
    let(:repository) { create(:repository, providers:) }

    context 'with a GitHub integration' do
      let(:providers) { { github: { id: 1, access_token: 'access_token' } } }

      it 'upserts repositories' do
        expect { command }.to change(repository.commits, :count)
      end
    end
  end
end
