# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Commit do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:repository) }

  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:commited_at) }
  it { is_expected.to validate_presence_of(:author) }

  context 'when creating a commit' do
    subject(:commit) { create(:commit) }

    it 'publishes a created event' do
      expect { commit }.to publish(an_event(Commit::Created)).in(Rails.configuration.event_store)
    end
  end
end
