# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_inclusion_of(:provider).in_array(Provider.to_a) }
  it { is_expected.to validate_presence_of(:token) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:account) }

  context 'when the access token is created' do
    subject { build(:access_token) }

    it { is_expected.to validate_uniqueness_of(:token).scoped_to(:account_id, :provider) }
  end
end
