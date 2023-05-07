# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe OnUserProvided do
    let(:user) { create(:user) }
    let(:payload) do
      {
        event_type: 'User::Provided',
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
