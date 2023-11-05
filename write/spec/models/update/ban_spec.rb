# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
  describe Ban do
    let(:update) { build(:update, :commit, tags:, source:) }
    let(:tags) { ['49699333+dependabot[bot]@users.noreply.github.com'] }
    let(:source) { create(:source, :repository) }

    before { update.validate }

    it 'blocks dependabot based on default banned keywords' do
      expect(update.errors.to_a).to eq ['Tags match a banned keyword']
    end
  end
end
