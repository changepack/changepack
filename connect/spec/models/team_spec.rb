# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:schema) }
  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:access_token).optional }
  it { is_expected.to have_many(:issues).dependent(:destroy) }
end
