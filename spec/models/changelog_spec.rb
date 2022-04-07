# frozen_string_literal: true

require 'rails_helper'

describe Changelog, type: :model do
  describe '#valid?' do
    subject { described_class.new(title:, content:, user:).valid? }

    let(:title) { 'Title' }
    let(:content) { 'Content' }
    let(:user) { create(:user) }

    it { is_expected.to be_truthy }

    context 'when title is not present' do
      let(:title) { nil }

      it { is_expected.to be_truthy }
    end

    context 'when content is not present' do
      let(:content) { nil }

      it { is_expected.to be_falsey }
    end
  end
end
