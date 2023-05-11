# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Commit
  describe Pull, :vcr do
    subject(:command) { Commit.pull(repository) }
    let(:repository) { create(:repository, providers:, access_token:) }

    context 'with a GitHub integration' do
      let(:providers) { { github: 1 } }
      let(:access_token) { create(:access_token, :github) }

      it 'upserts commits' do
        expect { command }.to change(repository.commits, :count)
      end
    end
  end
end
