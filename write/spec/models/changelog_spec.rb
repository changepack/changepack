# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Changelog do
  subject { build(:changelog) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:sources).dependent(:destroy) }
  it { is_expected.to have_many(:updates).dependent(:destroy) }

  it { is_expected.to validate_inclusion_of(:audience).in_array(described_class::AUDIENCES) }
  it { is_expected.to validate_presence_of(:audience) }
  it { is_expected.to validate_uniqueness_of(:custom_domain) }
end
