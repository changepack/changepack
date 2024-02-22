# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe Filter do
    describe '#filter_defaults!' do
      let!(:source) { create(:source, :repository) }

      it 'associates the filter keywords with the source' do
        ::Filter.defaults.each do |filter|
          expect(
            ::Filter.find_by(source:, trait: filter.trait, content: filter.content)
          ).to be_present
        end
      end
    end
  end
end
