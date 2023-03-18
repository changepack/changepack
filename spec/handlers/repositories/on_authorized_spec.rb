# typed: false
# frozen_string_literal: true

require 'rails_helper'

module Repositories
  describe OnAuthorized do
    let(:user) { create(:user) }
    let(:payload) do
      {
        event_type: 'Repository::Authorized',
        data: {
          provider: :github,
          access_token: 'access_token',
          account_id: user.account_id
        }
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
