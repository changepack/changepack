# frozen_string_literal: true

require 'rails_helper'

module Repositories
  describe OnAuthorized do
    let(:double) { instance_double(Repositories::Pull) }
    let(:user) { create(:user) }
    let(:payload) do
      {
        event_type: 'Repositories::Authorized',
        data: { user: user.id }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls repositories' do
      allow(Repositories::Pull).to receive(:new).and_return(double)
      allow(double).to receive(:execute).and_return(true)

      handler.perform(payload)

      expect(double).to have_received(:execute)
    end
  end
end
