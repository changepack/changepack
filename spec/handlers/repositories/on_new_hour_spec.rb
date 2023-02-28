# frozen_string_literal: true

require 'rails_helper'

module Repositories
  describe OnNewHour do
    let!(:repository) { create(:repository) }
    let(:payload) do
      {
        event_type: 'Clock::NewHour',
        data: { hour: 1 }
      }
    end

    subject(:handler) { described_class.new }

    context 'with inactive repositories' do
      it 'does nothing' do
        expect { handler.perform(payload) }.not_to publish(
          an_event(Repository::Outdated)
        ).in(Rails.configuration.event_store)
      end
    end

    context 'with active repositories' do
      it 'prepares to pull new data' do
        allow(Commit).to receive(:pull).and_return([])
        repository.transition_to!(:active)

        expect { handler.perform(payload) }.to publish(
          an_event(Repository::Outdated)
        ).in(Rails.configuration.event_store)
      end
    end
  end
end
