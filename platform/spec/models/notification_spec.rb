# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:deliveries) }
  it { is_expected.to have_many(:users).through(:deliveries) }
  it { is_expected.to validate_presence_of(:type) }

  describe '#channel' do
    subject { notification.valid? }

    let(:notification) { build(:notification, :custom, channel: Array(channel)) }

    context 'when channel is email' do
      let(:channel) { 'email' }

      it { is_expected.to be_truthy }
    end

    context 'when channel is sms' do
      let(:channel) { 'sms' }

      it { is_expected.to be_falsey }
    end
  end

  describe '#recipient' do
    subject { notification.users.to_a.sort }

    let(:user) { create(:user) }
    let(:notification) { create(:notification, :custom, account: user.account, recipient:) }

    context 'when recipient is a user' do
      let(:recipient) { user }

      it { is_expected.to eq [user].sort }
    end

    context 'when recipient is an account' do
      let(:recipient) { user.account }
      let!(:second_user_in_account) { create(:user, account: user.account) }

      # Create a user in a different account
      before { create(:user) }

      it { is_expected.to eq [user, second_user_in_account].sort }
    end
  end
end
