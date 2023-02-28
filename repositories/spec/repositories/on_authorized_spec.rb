# frozen_string_literal: true

require 'rails_helper'

module Repositories
  describe OnAuthorized do
    let(:user) { create(:user) }
    let(:payload) do
      {
        event_type: 'Repositories::Authorized',
        data: { user: user.id }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls repositories' do
      allow(Repository).to receive(:pull).and_return([])

      handler.perform(payload)

      expect(Repository).to have_received(:pull)
    end
  end
end
