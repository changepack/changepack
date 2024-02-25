# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Summary, :vcr do
  describe '#save' do
    subject(:summary) { described_class.new(newsletter:) }

    let(:newsletter) { create(:newsletter, account:) }
    let(:account) { create(:account, :production) }

    before do
      create(:template, category: :write, type: :summary)
      # Deterministic ID required for the API call
      create(:update, :commit, :production, account:, newsletter:, sourced_at:, id: 'upd_mj9Esq4bdtpY')
    end

    context 'when there are no updates within the last week' do
      let(:sourced_at) { 2.weeks.ago }

      it 'does not save the summary' do
        expect(summary.save).to be_falsey
      end
    end

    context 'when there are updates within the last week' do
      let(:sourced_at) { Time.current }

      it 'saves the summary' do
        expect(summary.save).to be_truthy
      end

      it 'sends an email' do
        expect { summary.save }.to change(Notification, :count).by(1)
      end
    end
  end
end
