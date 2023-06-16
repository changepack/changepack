# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Update::OnUpserted do
  subject(:handler) { described_class.new }

  describe '#run' do
    let(:update) { create(:update) }

    context 'when silence? returns true' do
      before do
        allow(handler).to receive(:silence?).and_return(true)
      end

      it 'does not update the update' do
        expect { handler.run }.not_to change { update.reload.attributes }
      end
    end

    context 'when silence? returns false' do
      before do
        allow(handler).to receive(:silence?).and_return(false)
      end

      it 'updates the update' do
        expect { handler.run }.to change { update.reload.attributes }
      end
    end
  end

  describe '#silence?' do
    context 'when update is blank' do
it 'returns true' do
  allow(update).to receive(:blank?).and_return(true)
  expect(handler.silence?).to be true
end
      # Test here
    end

    context 'when update is discarded' do
it 'returns true' do
  allow(update).to receive(:discarded?).and_return(true)
  expect(handler.silence?).to be true
end
      # Test here
    end

    context 'when update has a present context' do
it 'returns true' do
  allow(update).to receive_messages(context: double('Context', present?: true))
  expect(handler.silence?).to be true
end
      # Test here
    end

    context 'when update has a blank issue' do
it 'returns true' do
  allow(update).to receive_messages(issue: double('Issue', blank?: true))
  expect(handler.silence?).to be true
end
      # Test here
    end
  end
end
```
