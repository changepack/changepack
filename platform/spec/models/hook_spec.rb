# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hook do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to validate_presence_of(:request) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:direction) }
  it { is_expected.to validate_inclusion_of(:provider).in_array(Hook::PROVIDERS) }
  it { is_expected.to validate_inclusion_of(:direction).in_array(Hook::DIRECTIONS) }

  describe 'request' do
    context 'when provider is slack' do
      let(:slack_request) { build(:slack_request) }

      it 'is valid with valid attributes' do
        expect(slack_request).to be_valid
      end

      it 'validates presence of channel' do
        slack_request.channel = nil
        expect(slack_request).to validate_presence_of(:channel)
      end

      it 'validates presence of username' do
        slack_request.username = nil
        expect(slack_request).to validate_presence_of(:username)
      end

      it 'validates presence of webhook_url' do
        slack_request.webhook_url = nil
        expect(slack_request).to validate_presence_of(:webhook_url)
      end

      it 'validates webhook_url format' do
        slack_request.webhook_url = 'invalid_url'
        expect(slack_request).not_to be_valid
      end
    end
  end
end
