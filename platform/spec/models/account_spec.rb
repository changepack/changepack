# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Account do
  it { is_expected.to have_many(:users).dependent(:destroy) }
  it { is_expected.to have_many(:api_keys).dependent(:destroy) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:commits).dependent(:destroy) }
  it { is_expected.to have_many(:repositories).dependent(:destroy) }
  it { is_expected.to have_many(:updates).dependent(:destroy) }
  it { is_expected.to have_many(:teams).dependent(:destroy) }
  it { is_expected.to have_many(:issues).dependent(:destroy) }
  it { is_expected.to have_many(:changelogs).dependent(:destroy) }
  it { is_expected.to have_many(:access_tokens).dependent(:destroy) }
  it { is_expected.to have_one_attached(:picture) }

  it { is_expected.to allow_value('example.com').for(:domain) }

  context 'when the domain is valid' do
    subject { build(:account, domain: 'example.com') }

    it { is_expected.to validate_uniqueness_of(:domain) }
  end

  it 'is created when a user signs up' do
    expect { create(:user) }.to change(described_class, :count).by(1)
  end
end
