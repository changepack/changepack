# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Issue
  describe Pull, :vcr do
    subject(:command) { Issue.pull(team) }
    let(:team) { create(:team, access_token:) }

    context 'with a Linear integration' do
      let(:access_token) { create(:access_token, :linear) }

      it 'upserts issues' do
        expect { command }.to change(team.issues, :count)
      end
    end
  end
end
