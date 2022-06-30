# frozen_string_literal: true

require 'rails_helper'

module Repositories
  describe OnOutdated do
    let(:double) { instance_double(Commits::Pull) }
    let(:repository) { create(:repository) }
    let(:payload) do
      {
        event_type: 'Repositories::Outdated',
        data: { repository: repository.id }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls repositories' do
      allow(Commits::Pull).to receive(:new).and_return(double)
      allow(double).to receive(:execute).and_return(true)

      handler.perform(payload)

      expect(double).to have_received(:execute)
    end
  end
end
