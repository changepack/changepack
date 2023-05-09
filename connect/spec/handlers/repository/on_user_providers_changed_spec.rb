# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe OnUserProvidersChanged do
    let(:user) { create(:user, providers: { github: 1 }) }
    let(:payload) do
      {
        event_type: 'User::ProvidersChanged',
        data: {
          id: user.id,
          provider: 'github',
          providers: user.providers
        }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls repositories' do
      allow(Repository).to receive(:pull).and_return(true)

      handler.perform(payload)

      expect(Repository).to have_received(:pull)
    end
  end
end
