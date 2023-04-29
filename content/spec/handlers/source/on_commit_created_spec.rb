# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnRepositoryCreated do
    let(:user) { create(:user) }
    let(:repository) { create(:repository) }
    let(:payload) do
      {
        event_type: 'Repository::Created',
        data: {
          account_id: user.account_id,
          name: repository.name,
          id: repository.id
        }
      }
    end

    subject(:handler) { described_class.new }

    it 'creates a source for the repository' do
      expect { handler.perform(payload) }.to change(Source, :count).by(1)
    end

    context 'with attributes' do
      subject(:source) { Source.last }
      before { handler.perform(payload) }

      it { expect(source.type).to eq 'repository' }
      it { expect(source.account_id).to eq user.account_id }
      it { expect(source.repository_id).to eq repository.id }
      it { expect(source.name).to eq repository.name }
    end
  end
end
