# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnRepositoryUpdated do
    let(:user) { create(:user) }
    let(:repository) { create(:repository) }
    let(:source) { create(:source, repository:) }
    let(:name) { 'New name' }

    let(:payload) do
      {
        event_type: 'Repository::Updated',
        data: {
          account_id: repository.account_id,
          status: repository.status,
          id: repository.id,
          name:
        }
      }
    end

    subject(:handler) { described_class.new }

    it 'destroys the source' do
      expect { handler.perform(payload) }.to change { source.reload.name }.to(name)
    end
  end
end
