# frozen_string_literal: true

require 'rails_helper'

describe Account, type: :model do
  it { is_expected.to have_many(:users).dependent(:destroy) }
  it { is_expected.to have_many(:changelogs).dependent(:destroy) }
  it { is_expected.to have_many(:commits).dependent(:destroy) }
  it { is_expected.to have_many(:repositories).dependent(:destroy) }

  it 'is created when a user signs up' do
    expect { create(:user) }.to change(described_class, :count).by(1)
  end
end
