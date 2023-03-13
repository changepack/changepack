# frozen_string_literal: true

require 'rails_helper'

class Commit
  describe Git, :vcr do
    subject(:command) { Commit.pull(repository) }
    let(:repository) { create(:repository, providers:) }

    context 'with a GitHub integration' do
      context 'without a token' do
        let(:providers) { {} }

        it "doesn't execute" do
          expect { command }.not_to change(repository.commits, :count)
        end
      end

      context 'with a token' do
        let(:providers) { { github: { id: '1', access_token: 'access_token' } } }

        it 'upserts repositories' do
          expect { command }.to change(repository.commits, :count)
        end
      end
    end
  end
end
