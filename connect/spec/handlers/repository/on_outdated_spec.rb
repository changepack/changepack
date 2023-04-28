# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe OnOutdated do
    let(:double) { instance_double(Repository) }
    let(:repository) { create(:repository) }
    let(:payload) do
      {
        event_type: 'Repository::Outdated',
        data: { repository_id: repository.id }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls repositories' do
      allow(handler).to receive(:repository).and_return(double)
      allow(double).to receive(:pull).and_return(true)

      handler.perform(payload)

      expect(double).to have_received(:pull)
    end
  end
end
