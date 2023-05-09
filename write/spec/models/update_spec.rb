# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Update do
  subject { build(:update, :commit) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:post).optional }
  it { is_expected.to belong_to(:issue).optional }
  it { is_expected.to belong_to(:commit).optional }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:issue_id).scoped_to(:account_id) }
  it { is_expected.to validate_uniqueness_of(:commit_id).scoped_to(:account_id) }
  it { is_expected.to validate_inclusion_of(:type).in_array(described_class::TYPES) }
end
