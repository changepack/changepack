# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnRepositoryCreated do
    let(:repository) { create(:repository) }
    let(:payload) do
      {
        event_type: 'Repository::Created',
        data: Repository::Resource.to_event(repository)
      }
    end

    subject(:handler) { described_class.new }

    it 'creates a source for the repository' do
      expect { handler.perform(payload) }.to change(Source, :count).by(1)
    end

    context 'with attributes' do
      subject(:source) { Source.last }
      before { handler.perform(payload) }

      specify { expect(source.type).to eq 'repository' }
      specify { expect(source.account_id).to eq repository.account_id }
      specify { expect(source.repository_id).to eq repository.id }
      specify { expect(source.name).to eq repository.name }
    end
  end
end
