# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnTeamCreated do
    let(:team) { create(:team) }
    let(:payload) do
      {
        event_type: 'Team::Created',
        data: Team::Resource.to_event(team)
      }
    end

    subject(:handler) { described_class.new }

    it 'creates a source for the team' do
      expect { handler.perform(payload) }.to change(Source, :count).by(1)
    end

    context 'with attributes' do
      subject(:source) { Source.last }
      before { handler.perform(payload) }

      specify { expect(source.type).to eq 'team' }
      specify { expect(source.account_id).to eq team.account_id }
      specify { expect(source.team_id).to eq team.id }
      specify { expect(source.name).to eq team.name }
    end
  end
end
