# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Commit, type: :model do
  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:commited) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_inclusion_of(:provider).in_array(Provider.types) }
  it { is_expected.to validate_presence_of(:provider_id) }

  it { is_expected.to belong_to(:changelog).optional }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:repository) }
end
