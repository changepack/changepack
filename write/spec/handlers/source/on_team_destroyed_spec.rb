# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnTeamDestroyed do
    let(:team) { create(:team) }
    let!(:source) { create(:source, team:) }
    let(:payload) do
      {
        event_type: 'Team::Destroyed',
        data: Team::Resource.to_event(team)
      }
    end

    subject(:handler) { described_class.new }

    it 'destroys the source' do
      handler.perform(payload)

      expect(Source.find_by(id: source.id)).to be_nil
    end
  end
end
