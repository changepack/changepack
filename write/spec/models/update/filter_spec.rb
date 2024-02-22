# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
  describe Filter do
    let(:update) { build(:update, :commit, tags:, source:) }
    let(:tags) { ['49699333+dependabot[bot]@users.noreply.github.com'] }
    let(:source) { create(:source, :repository) }

    context 'when default filters are enabled' do
      before { update.validate }

      it 'blocks dependabot based on the default filters' do
        expect(update.errors.to_a).to eq ['Tags rejected by a filter']
      end
    end

    context 'when a filter must be matched' do
      before do
        create(:filter, source:, type: :select, content: 'john.doe')
        update.validate
      end

      context 'when tags match' do
        let(:tags) { ['john.doe@example.com'] }

        it 'passes' do
          expect(update.errors.to_a).to eq []
        end
      end

      context 'when tags not match' do
        let(:tags) { ['jane.doe@example.com'] }

        it 'blocks' do
          expect(update.errors.to_a).to eq ['Tags must match a filter']
        end
      end
    end
  end
end
