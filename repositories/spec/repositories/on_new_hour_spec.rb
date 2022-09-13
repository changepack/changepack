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
          an_event(Repositories::Outdated)
        ).in(Rails.configuration.event_store)
      end
    end

    context 'with active repositories' do
      before { repository.transition_to!(:active) }

      it 'prepares to pull new data' do
        expect { handler.perform(payload) }.to publish(
          an_event(Repositories::Outdated)
        ).in(Rails.configuration.event_store)
      end
    end
  end
end
