# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slack::Channel do
  it { is_expected.to belong_to(:account) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:webhook_url) }
  it { is_expected.not_to allow_value('not_a_url').for(:webhook_url) }
  it { is_expected.to allow_value('http://example.com/webhook').for(:webhook_url) }

  context 'when normalizing attributes' do
    subject(:channel) { build(:slack_channel, name: ' Channel Name ', username: ' UserName ') }

    it 'normalizes name to be lowercase and stripped' do
      expect(channel.name).to eq('channel name')
    end

    it 'strips the username' do
      expect(channel.username).to eq('UserName')
    end
  end
end
