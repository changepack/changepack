# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:token) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:teams).dependent(:nullify) }
  it { is_expected.to have_many(:repositories).dependent(:nullify) }

  context 'when the access token is created' do
    subject { build(:access_token, :github) }

    it { is_expected.to validate_uniqueness_of(:token).scoped_to(:account_id, :type) }
  end
end
