# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Team
  describe OnOutdated do
    let(:double) { instance_double(Team) }
    let(:team) { create(:team) }
    let(:payload) do
      {
        event_type: 'Team::Outdated',
        data: { team_id: team.id }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls repositories' do
      allow(handler).to receive(:team).and_return(double)
      allow(double).to receive(:pull).and_return(true)

      handler.perform(payload)

      expect(double).to have_received(:pull)
    end
  end
end
