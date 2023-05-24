# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Summary, :vcr do
  describe '#save' do
    subject(:summary) { described_class.new(changelog:) }

    let(:changelog) { create(:changelog, account:) }
    let(:account) { create(:account, :production) }

    context 'when there are no updates' do
      it 'does not save the summary' do
        expect(summary.save).to be_falsey
      end
    end

    context 'when there are updates' do
      # Deterministic ID required for the API call
      let(:id) { 'upd_mj9Esq4bdtpY' }

      before { create(:update, :commit, :production, account:, changelog:, id:) }

      it 'saves the summary' do
        expect(summary.save).to be_truthy
      end

      it 'sends an email' do
        expect { summary.save }.to have_enqueued_email(SummaryMailer, :notify)
      end
    end
  end
end
