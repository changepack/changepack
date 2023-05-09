# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnRepositoryUpdated do
    let(:repository) { create(:repository) }
    let(:source) { create(:source, :repository, repository:) }
    let(:name) { 'New name' }

    let(:payload) do
      {
        event_type: 'Repository::Updated',
        data: Repository::Resource.to_event(repository).merge(name:)
      }
    end

    subject(:handler) { described_class.new }

    it 'destroys the source' do
      expect { handler.perform(payload) }.to change { source.reload.name }.to(name)
    end
  end
end
