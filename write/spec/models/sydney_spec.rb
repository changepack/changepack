# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sydney, :vcr do
  subject(:sydney) { described_class.new(account:) }

  let(:account) { create(:account) }
  let(:updates) { create_list(:update, 2, account:) }

  around do |example|
    ClimateControl.modify OPENAI_ACCESS_TOKEN: 'test' do
      example.run
    end
  end

  describe '#hallucinate' do
    # We need the param to be an ActiveRecord::RelationType
    subject(:hallucinate) { sydney.hallucinate(Update.all) }

    it 'returns a hallucinated post' do
      expect(hallucinate).to be_a(String)
    end
  end

  describe '#choose' do
    subject(:choose) { sydney.choose(Update.all) }

    it 'returns a hallucinated post' do
      expect(choose).to be_a(String)
    end
  end
end
