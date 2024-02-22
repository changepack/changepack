# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Filter do
  subject { build(:filter) }

  it { is_expected.to belong_to(:source) }
  it { is_expected.to validate_presence_of(:trait) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_uniqueness_of(:content).scoped_to(:trait, :source_id) }
  it { is_expected.to validate_inclusion_of(:trait).in_array(described_class::TRAITS) }
end
