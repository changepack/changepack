# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Commit do
  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:commited_at) }
  it { is_expected.to validate_presence_of(:author) }

  it { is_expected.to belong_to(:post).optional }
  it { is_expected.to belong_to(:changelog).optional }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:repository) }
end
