# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Update::OnUpserted do
  subject(:handler) { described_class.new }

  describe '#run' do
    let(:id) { SecureRandom.uuid }
    let(:double) { instance_double(Sydney) }
    let(:update) { create(:update, :issue, id:) }
    let(:payload) do
      {
        event_type: 'Update::Upserted',
        data: { id: }
      }
    end

    before do
      allow(Sydney).to receive(:new).and_return(double)
      allow(double).to receive(:context).and_return('Test')
    end

    def perform
      handler.perform(payload)
    end

    def context
      update.reload.context
    end

    it 'saves context' do
      expect { perform }.to change { context }.to('Test')
    end

    context 'when update is blank' do
      let(:update) { nil }

      it 'keeps context empty' do
        expect { perform }.not_to change(Update, :count)
      end
    end

    context 'when update is discarded' do
      before { update.discard }

      it 'keeps context empty' do
        expect { perform }.not_to(change { context })
      end
    end

    context 'when update has context' do
      before { update.update!(context: 'Test') }

      it 'keeps context empty' do
        expect { perform }.not_to(change { context })
      end
    end

    context 'when update originates from a commit' do
      let(:update) { create(:update, :commit) }

      it 'keeps context empty' do
        expect { perform }.not_to(change { context })
      end
    end
  end
end
