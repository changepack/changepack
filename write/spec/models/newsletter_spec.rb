# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Newsletter do
  subject { build(:newsletter) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:sources).dependent(:destroy) }
  it { is_expected.to have_many(:updates).dependent(:destroy) }
end
