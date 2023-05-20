# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::Key do
  # it { is_expected.to belong_to(:bearer) }

  context 'when the API Key is created' do
    subject { build(:api_key) }

    it { is_expected.to validate_uniqueness_of(:token) }
  end
end
