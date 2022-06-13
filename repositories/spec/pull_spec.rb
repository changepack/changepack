# frozen_string_literal: true

require 'rails_helper'

module Repositories
  describe Pull do
    subject(:operation) { described_class.new(user:) }
    let(:user) { create(:user) }
    let(:instance) { provider.new(user:) }

    before { allow(instance).to receive(:perform).and_return(true) }

    context 'with a GitHub integration' do
      let(:provider) { Repositories::GitHub::Pull }

      before { allow(operation).to receive(:github).and_return(instance) }

      context 'without a token' do
        it "doesn't perform" do
          operation.perform

          expect(instance).not_to have_received(:perform)
        end
      end

      context 'with a token' do
        let(:user) { create(:user, provider_ids: { github: { access_token: 'access_token' } }) }

        it 'performs' do
          operation.perform

          expect(instance).to have_received(:perform)
        end
      end
    end
  end
end
