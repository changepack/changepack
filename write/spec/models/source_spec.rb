# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Source do
  subject { build(:source, :repository) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:repository).optional }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_inclusion_of(:type).in_array(described_class::TYPES) }
  it { is_expected.to validate_uniqueness_of(:repository_id).scoped_to(:account_id) }
end
