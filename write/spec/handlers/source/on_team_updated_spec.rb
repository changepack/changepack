# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnTeamUpdated do
    let(:team) { create(:team) }
    let(:source) { create(:source, team:) }
    let(:name) { 'New name' }

    let(:payload) do
      {
        event_type: 'Team::Updated',
        data: Team::Resource.to_event(team).merge(name:)
      }
    end

    subject(:handler) { described_class.new }

    it 'destroys the source' do
      expect { handler.perform(payload) }.to change { source.reload.name }.to(name)
    end
  end
end
