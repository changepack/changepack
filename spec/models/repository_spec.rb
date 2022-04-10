# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe '#valid?' do
    subject do
      described_class.new(
        account: user.account,
        user:,
        name:,
        default_branch:,
        provider:,
        provider_id:
      ).valid?
    end

    let(:user) { create(:user) }
    let(:name) { "#{Faker::App.name.downcase}/#{Faker::App.name.downcase}" }
    let(:default_branch) { :main }
    let(:provider) { :github }
    let(:provider_id) { Faker::Number.number(digits: 10) }

    it { is_expected.to be_truthy }

    context 'when name is not present' do
      let(:name) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when branch is not present' do
      let(:default_branch) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when provider is not present' do
      let(:provider) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when provider_id is not present' do
      let(:provider_id) { nil }

      it { is_expected.to be_falsey }
    end
  end
end
