# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Changelog do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
end
