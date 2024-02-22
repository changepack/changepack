# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Filter do
  subject { build(:filter) }

  it { is_expected.to belong_to(:source) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:trait) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_inclusion_of(:type).in_array(described_class::TYPES) }
  it { is_expected.to validate_inclusion_of(:trait).in_array(described_class::TRAITS) }
  it { is_expected.to validate_uniqueness_of(:content).scoped_to(:trait, :type, :source_id) }
end
