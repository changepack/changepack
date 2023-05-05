# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forbidden do
  subject { build(:forbidden) }

  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to belong_to(:changelog) }
  it { is_expected.to validate_inclusion_of(:type).in_array(described_class::TYPES) }
  it { is_expected.to validate_uniqueness_of(:content).scoped_to(:type, :changelog_id) }
end
