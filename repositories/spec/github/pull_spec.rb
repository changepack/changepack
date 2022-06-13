# frozen_string_literal: true

require 'rails_helper'

module Repositories
  module GitHub
    describe Pull, :vcr do
      subject(:operation) { described_class.new(user:) }
      let(:user) { create(:user, provider_ids: { github: { access_token: 'access_token' } }) }

      it 'upserts repositories' do
        expect { operation.perform }.to change(user.repositories, :count)
      end
    end
  end
end
