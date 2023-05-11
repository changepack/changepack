# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Team
  describe OnNewHour do
    let!(:team) { create(:team) }
    let(:payload) do
      {
        event_type: 'Clock::NewHour',
        data: { hour: 1 }
      }
    end

    subject(:handler) { described_class.new }

    context 'with inactive teams' do
      it 'does nothing' do
        expect { handler.perform(payload) }.not_to publish(
          an_event(Team::Outdated)
        ).in(Rails.configuration.event_store)
      end
    end

    context 'with active teams' do
      it 'prepares to pull new data' do
        allow(Commit).to receive(:pull).and_return([])
        team.transition_to!(:active)

        expect { handler.perform(payload) }.to publish(
          an_event(Team::Outdated)
        ).in(Rails.configuration.event_store)
      end
    end
  end
end
