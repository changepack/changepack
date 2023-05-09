# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sydney, :vcr do
  subject(:sydney) { described_class.new(account:) }

  let(:account) { create(:account) }

  before { create_list(:update, 2, :commit, account:) }

  around do |example|
    ClimateControl.modify OPENAI_ACCESS_TOKEN: 'test' do
      example.run
    end
  end

  describe '#hallucinate' do
    subject(:result) { sydney.hallucinate(Update.all) }

    specify { expect(result).to be_a(String) }
  end

  describe '#choose' do
    subject(:result) { sydney.choose(Update.all) }

    specify { expect(result).to be_a(String) }
  end
end
